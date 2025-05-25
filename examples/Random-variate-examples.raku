#!/usr/bin/env perl6

use Data::Generators;

##===========================================================

use Data::Generators;

sub mean(@x) { [+](@x) / @x.elems }
sub sd(@x) { sqrt( [+]((@x X- mean(@x)) X** 2) / @x.elems ) }

my $size = 100;
#my @res = random-variate(NormalDistribution.new(µ => 100, σ => 1), $size);
my @res = random-variate(NormalDistribution.new(mean => 100, sd => 1), $size);
my @res2 = random-variate(NormalDistribution.new, $size);
my @res3 = random-variate(NormalDistribution.new(100,20), $size);

my $µ = mean(@res);
say (:$µ);

my $σ = sd(@res);
say (:$σ);

$µ = mean(@res3);
say (:$µ);

$σ = sd(@res3);
say (:$σ);


say abs(mean(@res)) < 0.06 and 0 < sd(@res) <= 1.0;

#------------------------------------------------------------
say "-" x 60;

$size = 1000;
@res = random-variate(UniformDistribution.new(min => -3, max => 4), $size);
@res2 = random-variate(UniformDistribution.new, $size);

say @res;

$µ = mean(@res);
say (:$µ);

$σ = sd(@res);
say (:$σ);

#------------------------------------------------------------
say "-" x 60;

my $res8 = random-variate(NormalDistribution.new, [4, 3]);

say $res8;

say $res8 ~~ Array;
say $res8.shape eqv (4, 3);

say ($res8 ~~ Array and $res8.shape eqv (4, 3));
