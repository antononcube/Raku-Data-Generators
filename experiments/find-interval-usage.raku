#!/usr/bin/env raku
use v6.d;

use Data::Generators;
use Data::Generators::Utilities;

#`[
my @x = 2...18;
my @v = (5, 10, 15);
my @result = find-interval(@x, @v);
]

my @x = 2...10;
my @v = (3, 6, 9);
my @result = find-interval(@x, @v);

say (@x Z @result).raku;

say '-' x 120;

my @result2 = find-interval(@x, @v, :all-inside);

say (@x Z @result2).raku;

say '-' x 120;

my @result3 = find-interval(@x, @v, :left-open);

say (@x Z @result3).raku;
