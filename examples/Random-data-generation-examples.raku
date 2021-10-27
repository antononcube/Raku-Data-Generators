#!/usr/bin/env perl6

use lib './lib';
use lib '.';

use Data::Generators;

##===========================================================
say random-word(12);
say random-word(12, type => 'common').raku;
say random-word(12, type => 'known').raku;
say random-word(12, type => 'stop').raku;

##===========================================================
say "=" x 60;

say random-pretentious-job-title(6, number-of-words => Whatever, language => Whatever).raku;
say random-pretentious-job-title(6, number-of-words => Whatever, language => 21).raku;
