#!/usr/bin/env perl6

use lib './lib';
use lib '.';

use Data::Generators;

##===========================================================
say random-pet-name(8).raku;
say random-pet-name(8, species => 'Cat').raku;
say random-pet-name(8, species => 'Dog').raku;

##===========================================================
say random-word(8).raku;
say random-word(6, type => 'common').raku;
say random-word(6, type => 'known').raku;
say random-word(6, type => 'stop').raku;

##===========================================================
say "=" x 60;

say random-pretentious-job-title(6, number-of-words => Whatever, language => Whatever).raku;
say random-pretentious-job-title(6, number-of-words => Whatever, language => 21).raku;
