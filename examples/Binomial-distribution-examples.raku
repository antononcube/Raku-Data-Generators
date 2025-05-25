#!/usr/bin/env raku
use v6.d;

use Data::Generators;
use Stats;
use Text::Plot;


my @data = random-variate(BinomialDistribution.new(:10n, :p(0.4)), 10000);

my @data2 = @data.BagHash.Hash.kv.rotor(2);

note @data2.sort(*.head);

say text-list-plot(@data2);

say "mean     : {mean(@data)}, should be {10 * 0.4}";
say "variance : {variance(@data)}, should be {10 * 0.4 * (1 - 0.4)}";