use Data::Generators;

use Test;
plan 12;

## 1
ok random-pet-name(8), 'simple call 1';

## 2
ok random-pet-name(1), 'simple call 2';

## 3
is random-pet-name(12, species => 'Dog').all ~~ Str,
        True,
        'list of 12 dog names';

## 4
is random-pet-name(12, species => 'Any').all ~~ Str,
        True,
        'list of 12 Any pet names';

## 5
is random-pet-name(100, species => 'Cat').all ~~ Str,
        True,
        'list of 100 cat names';


## 6
is random-pet-name(100, species => 'pig').all ~~ Str,
        True,
        'list of 100 pig names';

## 7
is random-pet-name(100, species => Whatever).all ~~ Str,
        True,
        'list of 100 Whatever pet names';

## 8
is random-pet-name(100, species => Whatever, method => &pick).all ~~ Str,
        True,
        'list of picked 100 Whatever pet names';

## 9
dies-ok { random-pet-name(0) },
        'Zero number of pet names';

## 10
dies-ok { random-pet-name(-3) },
        'Negative number of pet names';

## 11
is random-pet-name(Whatever).elems ≥ 20_000, True,
        'Whatever number of pet names';

## 12
is random-pet-name(Whatever, method => WhateverCode).elems ≥ 20_000, True,
        'Whatever number of pet names with WhateverCode method';


done-testing;
