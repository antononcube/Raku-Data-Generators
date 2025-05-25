#!/usr/bin/env perl6

use lib './lib';
use lib '.';

#use Data::Generators::ResourceAccess;
#
#my Data::Generators::ResourceAccess $resources.instance;
#
###===========================================================
#say $resources.get-random-common-word(5);
#say $resources.get-random-known-word(5);
#say $resources.get-stop-words();

##===========================================================

#`(
my $fileName = $*CWD ~ '/resources/dfPetNameCounts.csv';

my $text = slurp $fileName.Str;
my @petNames = $text.split("\n").map({ $_.split('",').List });
@petNames = @petNames[1..*-1];
@petNames = @petNames.grep({ $_.elems == 3 });

say @petNames.elems;
say @petNames.map({ $_.elems }).classify({ $_ }).map({ $_.key => $_.value.elems });
say @petNames[^3].raku;

# Convert the count to integers.
@petNames = do for @petNames -> $row {
    ( $row[0].substr(1,*), $row[1].substr(1,*), +$row[2])
}
note @petNames[^3].raku;

# Make word data dictionary
my %specieToPetNames = @petNames.classify({ $_[0] }).map({ $_.key => Mix($_.value.map({ $_[1] => $_[2] })) });

say %specieToPetNames.map({ $_.value.elems });
say %specieToPetNames.map({ $_.key => $_.value.roll(3) });

say %specieToPetNames<Cat>.keys.pick(4).List;
)

##===========================================================


my $fileName = $*CWD ~ '/resources/dfEnglishWords.csv';

my $text = slurp $fileName.Str;
my @englishWords = $text.split("\n").map({ $_.split(',') });
@englishWords = @englishWords[1..*-1];

# Convert the logical fields into Booleans.
my $k = 0;
@englishWords = do for @englishWords -> $row {
    ( $row[0], $row[1] eq 'True', $row[2] eq 'True', $row[3] eq 'True', $k++)
}

say @englishWords.pick(3);

# Make word data dictionary
my %englishWords = @englishWords.map({ $_[0] => $_ });

# Create word type indexes
my %typeToIndexes =
        known => @englishWords.grep({ $_[1] }).map({ $_[4] }),
        common => @englishWords.grep({ $_[2]}).map({ $_[4] }),
        stopword => @englishWords.grep({ $_[3] }).map({ $_[4] });

say %typeToIndexes.map({ $_.key => $_.value.elems })