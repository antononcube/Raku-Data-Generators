#!/usr/bin/env perl6

use lib './lib';
use lib '.';

use Data::Generators;
use Data::Generators::RandomPretentiousJobTitle;
use Data::Generators::RandomWord;


##===========================================================
say random-word(12);
say random-word(12, type => 'common');
say random-word(12, type => 'known');
say random-word(12, type => 'stop');

##===========================================================
say "=" x 60;

say random-pretentious-job-title(6, number-of-words => Whatever, language => Whatever).raku;
say random-pretentious-job-title(6, number-of-words => Whatever, language => 21).raku;
