
unit module Data::Generators::RandomVariate;

#============================================================
# Distributions
#============================================================

#| Normal distribution class
class NormalDistribution is export {
    has Numeric $.mean = 0; #= Mean of the Normal distribution
    has Numeric $.sd = 1; #= Standard Deviation of the Normal distribution
    submethod BUILD(:µ(:$!mean), :σ(:$!sd)) { }
    method new() { self.bless(:mean(0), :sd(1)) }
}
#= Normal distribution objects are specified with mean and standard deviation.

#| Uniform distribution class
class UniformDistribution is export {
    has Numeric $.min = 0; #= Min boundary of the Uniform distribution
    has Numeric $.max = 1; #= Max boundary of the Uniform distribution
}
#= Uniform distribution objects are specified with min and max boundaries.

#============================================================
# RandomVariate
#============================================================

#| Gives a pseudorandom variate from the distribution $dist.
our proto RandomVariate( $dist, $size ) is export {*}

#------------------------------------------------------------
multi RandomVariate($dist ,
                    @size where { $_.all ~~ Numeric and [and]($_.map({ $_ > 0 })) and $_.elems == 2}) {
    my @res = RandomVariate( $dist, [*] @size).List;
    my @res2[@size[0];@size[1]] = @res.rotor(@size[1]);
    @res2
}

#------------------------------------------------------------
sub rnorm(Numeric $µ, Numeric $σ) {
    sqrt( -2 * log(rand)) * cos(2 * π * rand) * $σ + $µ;
}

multi RandomVariate($dist where $_ ~~ NormalDistribution, UInt $size --> List) {
    (rnorm($dist.mean, $dist.sd) xx $size).List
}

#------------------------------------------------------------
multi RandomVariate($dist where $_ ~~ UniformDistribution, UInt $size --> List) {
    (($dist.min..$dist.max).rand xx $size).List
}
