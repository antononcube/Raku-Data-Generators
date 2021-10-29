use lib './lib';
use lib '.';

use Data::Generators;

use Test;

plan 4;

## 1
ok random-string(8), 'simple call 1';

## 2
ok random-string(1), 'simple call 2';

## 3
is random-string(12, chars => 4, ranges => [<1 8 A>, <Y H>, "0".."9" ] ).all ~~ Str,
        True,
        'list of 12 strings';

## 4
is random-string(10, chars => Whatever, ranges => Whatever ).all ~~ Str,
        True,
        'list of 10 strings with Whatever number of characters and Whatever ranges';

done-testing;
