use Test;

use lib './lib';
use lib '.';

use Data::Generators;

plan 7;

## 1
ok random-word(8), 'simple call 1';

## 2
ok random-word(1), 'simple call 2';

## 3
is random-word(12, type => 'known').all ~~ Str,
        True,
        'list of 12 known words';

## 4
is random-word(12, type => 'Any').all ~~ Str,
        True,
        'list of 12 Any words';

## 5
is random-word(100, type => 'common').all ~~ Str,
        True,
        'list of 100 common words';


## 6
is random-word(100, type => 'stop').all ~~ Str,
        True,
        'list of 100 stop words';

## 7
is random-word(100, type => Whatever).all ~~ Str,
        True,
        'list of 100 Whatever words';

done-testing;
