#!/usr/bin/env perl6

use lib './lib';
use lib '.';

use Data::Reshapers;
use Data::RandomDataGenerators::RandomPretentiousJobTitle;

say RandomPretentiousJobTitle(6, number-of-words => Whatever, language => 21).raku;

say RandomPretentiousJobTitle(6, number-of-words => Whatever, language => Whatever).raku;
