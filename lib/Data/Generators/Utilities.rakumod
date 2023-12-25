unit module Data::Generators::Utilities;

#------------------------------------------------------------
sub normal-dist(Numeric $µ, Numeric $σ) is export {
    sqrt(-2 * log(rand)) * cos(2 * π * rand) * $σ + $µ;
}

#------------------------------------------------------------
proto sub factorial(Int $n) is export {*}

multi sub factorial(Int $n where $n ≤ 1) {
    return 1;
}

multi sub factorial(Int $n where !($n %% 2)) {
    return $n * factorial($n - 1);
}

multi sub factorial(Int $n is copy where $n %% 2) {

    my $f = $n;

    my $d = $n - 2;
    my $m = $n + $d;

    while $d > 0 {
        $f *= $m;
        $d -= 2;
        $m += $d;
    }

    return $f;
}

#------------------------------------------------------------
proto sub binomial(Int $n, Int $k) is export {*}

multi sub binomial(Int $n, Int $k) {
    if $n < $k || $n < 0 || $k < 0 {
        return 0;
    } else {
        return factorial($n) / (factorial($k) * factorial($n - $k));
    }
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


