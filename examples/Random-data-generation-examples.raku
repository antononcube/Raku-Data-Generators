#!/usr/bin/env perl6

use lib './lib';
use lib '.';

use Data::Generators;
use Data::Reshapers;

##===========================================================
say "=" x 60;
say random-string(8).raku;
say random-string(12, chars => 4, ranges => [<1 8 A>, <Y H>, "0".."9" ] ).raku;

##===========================================================
say "=" x 60;

my @dfWords = do for <Any Common Known Stop> -> $wt { $wt => random-word(6, type => $wt) };
say to-pretty-table(@dfWords);

my @dfWords2 = do for <Common Known Stop> -> $wt { [ $wt, |random-word(6, type => $wt) ]};
say to-pretty-table(@dfWords2);

##===========================================================
say "=" x 60;
say random-pet-name(8).raku;
say random-pet-name(8, species => 'Any').raku;
say random-pet-name(8, species => 'Cat').raku;
say random-pet-name(8, species => 'Dog').raku;
say random-pet-name(8, species => 'Dog').raku;

my @dfPetNames = do for <Any Cat Dog Goat Pig> -> $sp { $sp => random-pet-name(6, species => $sp) };
say @dfPetNames.raku;
say to-pretty-table(@dfPetNames);

##===========================================================
say "=" x 60;

say random-pretentious-job-title(6, number-of-words => Whatever, language => Whatever).raku;
say random-pretentious-job-title(6, number-of-words => Whatever, language => 21).raku;
