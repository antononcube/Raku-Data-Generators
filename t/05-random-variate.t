use lib './lib';
use lib '.';

use Data::Generators;

sub mean(@x) {
    [+](@x) / @x.elems
}
sub sd(@x) {
    sqrt([+]((@x X- mean(@x)) X** 2) / @x.elems)
}

use Test;

plan 7;

## 1
is random-variate(NormalDistribution.new(:mean(10), :sd(20)), 12).all ~~ Numeric,
        True,
        'Normal distribution';

## 2
is random-variate(NormalDistribution.new(:µ(10), :σ(20)), 12).all ~~ Numeric,
        True,
        'Normal distribution alternative spec';

## 3
is random-variate(NormalDistribution.new, 12).all ~~ Numeric,
        True,
        'Normal distribution default arguments';

## 4
my @res4 = random-variate(NormalDistribution.new, 100);
is-approx abs(mean(@res4)), 0, 0.1,
        'Normal distribution mean and st. deviation with default arguments';

## 5
is-approx sd(@res4), 1.0, 0.3,
        'Normal distribution mean and st. deviation with default arguments';

## 6
is random-variate(UniformDistribution.new(:min(10), :max(20)), 12).all ~~ Numeric,
        True,
        'Uniform distribution';

## 7
is random-variate(UniformDistribution.new, 12).all ~~ Numeric,
        True,
        'Uniform distribution default arguments';

done-testing;
