use Test;

use lib './lib';
use lib '.';

use Data::Generators;

plan 7;

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

done-testing;
