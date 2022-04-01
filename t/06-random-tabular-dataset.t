use Data::Generators;

use Test;

sub is-array-of-hashes($tbl) { $tbl ~~ Array and $tbl.all ~~ Hash }
sub is-array-of-key-hash-pairs($tbl) { $tbl ~~ Array and $tbl.all ~~ Pair and ([and] $tbl.map({ $_.value ~~ Hash })) }

plan 8;

## 1
ok random-tabular-dataset(), 'simple call 1';

## 2
ok random-tabular-dataset(Whatever), 'simple call 2';

## 3
ok random-tabular-dataset(Whatever, Whatever), 'simple call 3';

## 4
ok random-tabular-dataset(12, Whatever), 'rows spec 1';

## 5
is is-array-of-hashes( random-tabular-dataset(10, <Col1 COL2 Col3>) ),
        True,
        'column names spec';

## 6
is is-array-of-hashes( random-tabular-dataset(10, 5) ),
        True,
        'columns count spec';

## 7
is is-array-of-hashes(random-tabular-dataset(4, 7, column-names-generator => { random-word($_, type => 'Stop') })),
        True,
        'columns count spec and column names generator';

## 8
is is-array-of-key-hash-pairs(random-tabular-dataset(4, 7):row-names),
        True,
        'columns count spec and row names';

done-testing;
