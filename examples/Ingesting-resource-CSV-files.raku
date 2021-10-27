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
my $fileName = "/Volumes/Macintosh HD/Users/antonov/Raku-Data-Generators/resources/dfPetNameCounts.csv";

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

use Data::Generators::RandomVariate;
#use Stats;

my $size = 1000;
my @res = RandomVariate(NormalDistribution.new(mean => 0, sd => 1), $size);

my $µ = [+](@res) / $size;
say (:$µ);

my $σ = sqrt [+](@res X** 2) / $size - $µ**2;
say (:$σ);

#------------------------------------------------------------

$size = 1000;
@res = RandomVariate(UniformDistribution.new(min => -3, max => 4), $size);

say @res;

$µ = [+](@res) / $size;
say (:$µ);

$σ = sqrt [+](@res X** 2) / $size - $µ**2;
say (:$σ);