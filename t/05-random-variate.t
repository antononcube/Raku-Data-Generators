use lib './lib';
use lib '.';

use Data::Generators;

use Test;

plan 2;

## 1
is random-variate(NormalDistribution.new(:mean(10), :sd(20)), 12).all ~~ Numeric,
        True,
        'Normal distribution';

## 2
is random-variate(UniformDistribution.new(:min(10), :max(20)), 12).all ~~ Numeric,
        True,
        'Normal distribution';

done-testing;
