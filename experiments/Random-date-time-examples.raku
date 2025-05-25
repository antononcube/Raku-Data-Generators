#!/usr/bin/env perl6

use Data::Generators;

##===========================================================

use Data::Generators;

#------------------------------------------------------------
say "-" x 60;

say random-date-time().raku;
say random-date-time(now.DateTime).raku;
say random-date-time((DateTime.new('2020-02-23'), now.DateTime), 12);

say [&&] random-date-time((DateTime.new('2020-02-23'), now.DateTime), 1002).map({ $_ ≤ now.DateTime });