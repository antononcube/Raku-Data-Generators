#!/usr/bin/env perl6

use Data::Generators;

##===========================================================

use Data::Generators;

#------------------------------------------------------------
say "-" x 60;

say random-real();
say random-real(1);
say random-real([0,8]);
say random-real([0,10], 4);
say random-real([0,10], [3,3]);


#------------------------------------------------------------
say "-" x 60;

my $res8 = random-real(1, [4, 3]);

say $res8;

say $res8 ~~ Array;
say $res8.shape eqv (4, 3);

say ($res8 ~~ Array and $res8.shape eqv (4, 3));
