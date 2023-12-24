unit module Data::Generators::Utilities;

#------------------------------------------------------------
sub rnorm(Numeric $µ, Numeric $σ) is export {
    sqrt( -2 * log(rand)) * cos(2 * π * rand) * $σ + $µ;
}

#------------------------------------------------------------
proto sub factorial(Int $n) is export {*}

multi sub factorial(Int $n where $n ≤ 1 ) { return 1; }

multi sub factorial(Int $n where !($n %% 2) ) {
    return $n * factorial($n-1);
}

multi sub factorial(Int $n is copy where $n %% 2 ) {

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