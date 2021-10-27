#!/usr/bin/env perl6

use lib './lib';
use lib '.';

use Data::Generators;

##===========================================================
say "=" x 60;
say random-string(8).raku;
say random-string(12, chars => 4, ranges => [<1 8 A>, <Y H>, "0".."9" ] ).raku;

##===========================================================
say "=" x 60;
say random-word(8).raku;
say random-word(6, type => 'Common').raku;
say random-word(6, type => 'known').raku;
say random-word(6, type => 'stop').raku;

##===========================================================
say "=" x 60;
say random-pet-name(8).raku;
say random-pet-name(8, species => 'Cat').raku;
say random-pet-name(8, species => 'Dog').raku;

##===========================================================
say "=" x 60;

say random-pretentious-job-title(6, number-of-words => Whatever, language => Whatever).raku;
say random-pretentious-job-title(6, number-of-words => Whatever, language => 21).raku;
