use lib './lib';
use lib '.';

use Data::Generators;

use Test;

plan 4;

## 1
ok random-pretentious-job-title(8), 'simple call 1';

## 2
ok random-pretentious-job-title(1), 'simple call 2';

## 3
is random-pretentious-job-title(12, number-of-words => 2, language => 'Bulgarian').all ~~ Str,
        True,
        'list of 12 job titles';

## 4
is random-pretentious-job-title(10, number-of-words => Whatever, language => Whatever ).all ~~ Str,
        True,
        'list of 10 job titles with Whatever number of words and Whatever language';

done-testing;
