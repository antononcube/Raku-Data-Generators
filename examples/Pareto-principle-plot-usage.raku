#!/usr/bin/env raku
use v6.d;

use Data::Generators;
use Data::Summarizers;

use Text::Plot;

random-pet-name(4, species => 'Any', method => &pick):!weighted;

my $stime = now;
my @pnames = random-pet-name(4000, species => 'Any', method => &pick):!weighted;
my $etime = now;
say "Generation time: {$etime - $stime}";

$stime = now;
my @pnames2 = random-pet-name(4000, species => 'Cat', method => &pick):!weighted;
$etime = now;
say "Generation time: {$etime - $stime}";


#say random-pet-name(Whatever, method => WhateverCode).elems;
#say random-pet-name(Whatever, method => &pick).elems;

say @pnames.head(12);
say @pnames2.head(12);

records-summary(@pnames2);

say tally(@pnames2).sort({ -$_.value });

say text-pareto-principle-plot(@pnames, title => 'Random pet names'):normalize;
say text-pareto-principle-plot(@pnames2, title => 'Random cat names'):normalize;