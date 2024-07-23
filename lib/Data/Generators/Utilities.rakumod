unit module Data::Generators::Utilities;

use Math::SpecialFunctions;

#------------------------------------------------------------
sub normal-dist(Numeric $µ, Numeric $σ) is export {
    sqrt(-2 * log(rand)) * cos(2 * π * rand) * $σ + $µ;
}


#------------------------------------------------------------
#| Given a vector of non-decreasing breakpoints in vec, find the interval containing each element of data;
#| i.e., if i = find-interval(x, v), for each index j in x where v[i[j]] ≤ x[j] < v[i[j]+1],
#| where v[0] = -Inf, v[N+1] = Inf and N = v.elems .
#| At the two boundaries, the returned index may differ by 1,
#| depending on the option arguments rightmost-closed and all-inside.
#| C<@data> -- numeric vector.
#| C<@vec> -- numeric vector sorted increasingly.
#| C<:$rightmost-closed> -- boolean; if true, the rightmost interval, vec[N-1] .. vec[N] is treated as closed, see below.
#| C<:$all.inside> -- boolean; if true, the returned indices are coerced into 1,...,N-1, i.e., 0 is mapped to 1 and N to N-1.
#| C<:$left.open> -- boolean; if true all the intervals are open at left and closed at right.
proto sub find-interval($data,
                        @vec,
                        Bool :$rightmost-closed = False,
                        Bool :$all-inside = False,
                        Bool :$left-open = False)
        is export {*}

multi sub find-interval(Numeric $data, @vec, *%args) {
    return find-interval([$data,], @vec, |%args).head;
}

multi sub find-interval(@data where @data.all ~~ Numeric,
                        @vec is copy where @vec.all ~~ Numeric,
                        Bool :$rightmost-closed = False,
                        Bool :$all-inside = False,
                        Bool :$left-open = False) {

    my $n = @vec.elems;

    # Augment boundaries
    @vec = @vec.sort.Array.append(Inf);

    my @indices = @data.map(-> $x {

        my $index = do if $left-open {
            @vec.first({ $_ >= $x }, :k);
        } else {
            @vec.first({ -$x > -$_ }, :k);
        }

        if $rightmost-closed and $x == @vec[*- 2] {
            $index = $n - 1;
        }

        $index;
    });

    if $all-inside {
        @indices = @indices.map({ $_ == 0 ?? 1 !! $_ >= $n ?? $n - 1 !! $_ });
    }

    return (@indices <<+>> -1).Array;
}

#------------------------------------------------------------
sub binomial-dist(Int $n, Numeric $p, Int :$size = 1) is export {

    my @vec = (0 .. $n).map(-> $x { binomial($n, $x) * $p ** $x * (1 - $p) ** ($n - $x) });

    @vec = [\+] [0, |@vec];

    return find-interval(rand xx $size, @vec);
}

#------------------------------------------------------------
sub exponential-dist(Numeric:D $lambda, Int :$size = 1) is export {
    my @u = rand xx $size;
    return @u.map({ - log($_) / $lambda });
}

#------------------------------------------------------------
# Using:
# George Marsaglia and Wai Wan Tsang. 2000. "A simple method for generating gamma variables."
# ACM Trans. Math. Softw. 26, 3 (Sept. 2000), 363–372.
# https://doi.org/10.1145/358407.358414
sub gamma-dist-marsaglia(Numeric:D $a) is export {
    if $a < 1 {
        die 'The first argument is expected to be larger or equal to 1.';
    }

    loop {
        my $x = normal-dist(0, 1);
        my $u = rand;
        my $d = $a - 1 / 3;
        my $c = 1 / sqrt(9 * $d);
        my $v = (1 + $c * $x) ** 3;
        if $v > 0 && log($u) < $x ** 2 / 2 + $d - $d * $v + $d * log($v) {
            return $d * $v
        }
    }
}

# Using Wikipedia's version of the Ahrens-Dieter acceptance–rejection method given here:
# https://en.wikipedia.org/wiki/Gamma_distribution#Random_variate_generation
sub gamma-dist(Numeric:D $a, Numeric:D $b) is export {
    my $delta = $a - $a.floor;
    my $xi;
    loop {
        my $u = rand;
        my $v = rand;
        my $w = rand;
        my $eta;
        # In general e can be used instead of exp(0), but highlighting gets confused.
        if $u ≤ exp(0) / ($delta + exp(0)) {
            $xi = $v ** (1 / $delta);
            $eta = $w * $xi ** ($delta - 1);
        } else {
            $xi = 1 - log($v);
            $eta = $w * exp(-$xi);
        }

        last if $eta ≤ $xi ** ($delta - 1) * exp(-$xi);
    }

    my $k = $a.floor;
    my $usum = (rand xx $k).grep({ $_ > 0 })».log.sum;
    return $b * ($xi - $usum);
}

#------------------------------------------------------------
sub beta-dist(Numeric:D $a, Numeric $b) is export {
    my $x = gamma-dist($a, 1);
    my $y = gamma-dist($b, 1);;
    return $x / ($x + $y);
}
