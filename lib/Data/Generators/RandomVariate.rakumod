unit module Data::Generators::RandomVariate;

use Data::Generators::Utilities;

#============================================================
# Distributions
#============================================================

#| Beta distribution class
class BetaDistribution is export {
    has Numeric $.a is required;
    #= Shape parameter left.
    has Numeric $.b is required;
    #= Shape parameter right.
    multi method new($a, $b) {
        self.bless(:$a, :$b)
    }
}
#= Beta distribution objects are specified with shape parameters.

#| Bernoulli distribution class
class BernoulliDistribution is export {
    has Numeric $.p = 0.5;
    #= Get value 1 with probability p
}
#= Bernoulli distribution objects are specified with probability parameter.

#| Binomial distribution class
class BinomialDistribution is export {
    has Numeric $.n = 2;
    #= Number of trials
    has Numeric $.p = 0.5;
    #= Success probability p
}
#= Binomial distribution objects are specified with number of trials and success probability.

#| Exponential distribution class
class ExponentialDistribution is export {
    has Numeric $.lambda = 0.5;
    #= Scale parameter
    multi method new($lambda) {
        self.bless(:$lambda)
    }
}
#= Exponential distribution objects are specified with scale inversely proportional to the lambda parameter.

#| Gamma distribution class
class GammaDistribution is export {
    has Numeric $.a = 0.5;
    has Numeric $.b = 0.5;
    multi method new($a, $b) {
        self.bless(:$a, :$b)
    }
}
#= Gamma distribution objects are specified shape parameter a and inverse scale parameter b.

#| Normal distribution class
class NormalDistribution is export {
    has Numeric $.mean = 0;
    #= Mean of the Normal distribution
    has Numeric $.sd = 1;
    #= Standard Deviation of the Normal distribution
    submethod BUILD(:µ(:$!mean) = 0, :σ(:$!sd) = 1) {}
    multi method new($mean, $sd) {
        self.bless(:$mean, :$sd)
    }
}
#= Normal distribution objects are specified with mean and standard deviation.

#| Uniform distribution class
class UniformDistribution is export {
    has Numeric $.min = 0;
    #= Min boundary of the Uniform distribution
    has Numeric $.max = 1;
    #= Max boundary of the Uniform distribution
    multi method new($min, $max) {
        self.bless(:$min, :$max)
    }
}
#= Uniform distribution objects are specified with min and max boundaries.

#============================================================
# RandomVariate
#============================================================

#| Gives a pseudorandom variate from the distribution $dist.
our proto RandomVariate($dist, |) is export {*}

#------------------------------------------------------------
multi RandomVariate($dist) {
    return RandomVariate($dist, 1)[0];
}

multi RandomVariate($dist ,
                    @size where { $_.all ~~ Numeric and [and]($_.map({ $_ > 0 })) and $_.elems == 2 }) {
    my @res = RandomVariate($dist, [*] @size).List;
    my @res2[@size[0];@size[1]] = @res.rotor(@size[1]);
    @res2
}

#------------------------------------------------------------
multi RandomVariate($dist, UInt $size --> List) {
    given $dist {
        when BetaDistribution {
            (beta-dist($_.a, $_.b) xx $size).List
        }
        when BernoulliDistribution {
            (rand xx $size).map({ $_ ≤ $dist.p ?? 1 !! 0 }).List
        }
        when BinomialDistribution {
            binomial-dist($dist.n, $dist.p, :$size).List
        }
        when ExponentialDistribution {
            exponential-dist($dist.lambda, :$size).List
        }
        when GammaDistribution {
            (gamma-dist($dist.a, $dist.b) xx $size).List
        }
        when NormalDistribution {
            (normal-dist($_.mean, $_.sd) xx $size).List
        }
        when UniformDistribution {
            (($_.min .. $_.max).rand xx $size).List
        }
        default {
            die "Unknown random variate class."
        }
    }
}
