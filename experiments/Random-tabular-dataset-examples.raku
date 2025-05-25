#!/usr/bin/env perl6

use Data::Generators;
use Data::Generators::RandomVariate;
use Data::Reshapers;

sub is-array-of-hashes($tbl) {
    $tbl ~~ Positional and $tbl.all ~~ Hash
}
sub is-array-of-key-hash-pairs($tbl) {
    $tbl ~~ Array and ([and] $tbl.map({ $_.value ~~ Hash }))
}

#my @dfRand = random-tabular-dataset(Whatever, random-pet-name(7, species => 'Cat') ):!row-names;
#my @dfRand = random-tabular-dataset(Whatever, Whatever):!row-names;
#my @dfRand = random-tabular-dataset(Whatever, <Col1 Col2 Col3>):!row-names;
#my @dfRand = random-tabular-dataset(4, 7, column-names-generator => { random-pet-name($_, species => 'Cat') }):row-names;

#my @dfRand =
#        random-tabular-dataset( 4, 7, generators => [&random-pet-name,
#                                                     &random-word,
#                                                     { RandomVariate(NormalDistribution.new(mean=>100, sd=>3), $_) }]);

# my @dfRand = random-tabular-dataset( 4, <mouse cat>, generators => {mouse => &random-pet-name, cat => &random-word} );

#my @dfRand = random-tabular-dataset(
#        4, <mouse cat human object semi color pasta>,
#        generators => {mouse => &random-pet-name, cat => <Tom Sasa Makiato>, object => &random-string} );

# my @dfRand = random-tabular-dataset(4, <mouse cat human object semi color pasta>, generators => &random-string);

# my @dfRand = random-tabular-dataset(12, 5, column-names-generator => &random-word, generators => [random-pet-name(4), &random-string]);

my @dfRand = random-tabular-dataset(1752, 5):row-names;

# my @dfRand = random-tabular-dataset(12, ["asa", "sama"], generators => { "asa" => random-pet-name(4), "sama" => &random-string});

say @dfRand;
say @dfRand.raku;

say to-pretty-table(@dfRand);

# say to-pretty-table([{"a"=>1, "b"=>3}, {"a"=>"", "b"=>3}]);
#
#my $naTbl=[{"a"=>1, "b"=>3}, {"a"=>Nil, "b"=>3}];
#say $naTbl.raku;
#say to-pretty-table($naTbl)
