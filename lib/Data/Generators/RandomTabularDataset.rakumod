use Data::Generators::RandomVariate;
use Data::Generators::RandomFunctions;

unit module Data::Generators::RandomTabularDataset;

#============================================================
sub is-positional-of-strings($vec) {
    ($vec ~~ Positional) and ($vec.all ~~ Str)
}

sub convert-to-hash-of-hashes(@tbl --> Hash) {
    @tbl.map({ $_.key => ($_.value.keys».Str.List Z=> $_.value.List).Hash }).Hash;
}

#============================================================
our proto RandomTabularDataset(|) is export {*}

multi RandomTabularDataset(*%args) {
    RandomTabularDataset(Whatever, Whatever, |%args)
}

multi RandomTabularDataset($nrow, *%args) {
    RandomTabularDataset($nrow, Whatever, |%args)
}

multi RandomTabularDataset($nrow is copy,
                           $colSpec is copy = Whatever,
                           :&column-names-generator is copy = WhateverCode,
                           :$form is copy = "wide",
                           :$generators is copy = Whatever,
                           :$min-number-of-values is copy = Whatever,
                           :$max-number-of-values is copy = Whatever,
                           Bool :$row-names = False --> Array) {

    # Process number of rows
    if $nrow.isa(Whatever) {
        $nrow = RandomVariate(NormalDistribution.new(mean => 12, sd => 10), 1)[0].Int;
        $nrow = $nrow <= 0 ?? 1 - $nrow !! $nrow;
    }
    if $nrow ~~ Numeric { $nrow .= Int }
    if not $nrow ~~ Int and $nrow > 0 {
        die "The argument 'nrow' is expected to be a positive integer or Whatever."
    }

    # Process number of columns
    my $ncol = Whatever;
    my $localColumnNames = Whatever;
    if $colSpec.isa(Whatever) {
        $ncol = RandomVariate(NormalDistribution.new(mean => 6, sd => 10), 1)[0].Int;
        $ncol = $ncol <= 0 ?? 1 - $ncol !! $ncol;
    } elsif is-positional-of-strings($colSpec) {
        $localColumnNames = $colSpec;
        $ncol = $localColumnNames.elems;
    } elsif $colSpec ~~ Numeric and $colSpec.Int > 0 {
        $ncol = $colSpec.Int;
    } else {
        die "The second, columns specification argument is expected to be a positive integer, a list of strings, or Whatever."
    }

    # Column names generator
    if $localColumnNames.isa(Whatever) {
        if &column-names-generator.isa(WhateverCode) {
            $localColumnNames = RandomWord($ncol, type => 'Common')
        } else {
            $localColumnNames = &column-names-generator($ncol)
        }
    }

    # Generators
    my %defaultGenerators;
    for |$localColumnNames -> $cn {
        my $r = rand;

        if $r < 0.3 {
            %defaultGenerators{$cn} = &RandomWord
        } elsif $r < 0.5 {
            %defaultGenerators{$cn} = &RandomString
        } elsif $r < 0.8 {
            %defaultGenerators{$cn} = -> $x { RandomVariate(NormalDistribution.new(mean => 12, sd => 10), $x) }
        } else {
            %defaultGenerators{$cn} = -> $x { RandomVariate(UniformDistribution.new(min => 0, max => 100), $x) }
        }
    }

    my %localGenerators;
    my $msgWrongGenerators = "Unknown type of generators specification.";

    if $generators.isa(Whatever) {

        %localGenerators = %defaultGenerators

    } elsif $generators ~~ Positional {

        my @extGenerators = do for |$generators -> $g {
            if $g ~~ Callable {
                $g
            } elsif $g ~~ Positional {
                -> $x { $g.List.roll($x).List }
            } else {
                die $msgWrongGenerators
            }
        }

        while @extGenerators.elems < $localColumnNames.elems {
            @extGenerators = [|@extGenerators, |@extGenerators]
        }

        %localGenerators = [|$localColumnNames] Z=> @extGenerators[^$localColumnNames.elems]

    } elsif $generators ~~ Map {

        %localGenerators = %defaultGenerators;
        for $generators.kv -> $k, $g {
            if $g ~~ Callable {
                %localGenerators{$k} = $g
            } elsif $g ~~ Positional {
                %localGenerators{$k} = -> $x { $g.List.roll($x).List }
            } else {
                die $msgWrongGenerators
            }
        }
    } elsif $generators ~~ Callable {

        %localGenerators = [|$localColumnNames] Z=> [$generators xx $localColumnNames.elems];

    } else {
        die $msgWrongGenerators
    }

    ## Max Number Of Values
    if $max-number-of-values.isa(Whatever) {
        $max-number-of-values = $nrow * $ncol
    }

    if not $max-number-of-values ~~ Numeric and $max-number-of-values > 0 {
        die "The argument 'maxNumberOfValues' is expected to be a non-negative integer or Whatever."
    }

    ## Min Number Of Values
    if $min-number-of-values.isa(Whatever) {
        $min-number-of-values = $nrow * $ncol
    }

    if not $min-number-of-values ~~ Numeric and $min-number-of-values > 0 {
        die "The argument 'minNumberOfValues' is expected to be a non-negative integer or Whatever."
    }

    ## Form
    if $form.isa(Whatever) { $form = Mix(long => 0.3, wide => 0.7).pick }

    if not $form ~~ Str and $form.lc (elem) <Long Wide>.lc {
        warn "The argument 'form' is expected to be Whatever or one of 'Long' or 'Wide'. Continuing using 'Wide'.";
        $form = "wide"
    }

    $form = $form.lc;

    # Generate random values
    my @dfRes is Array =
            do for |$localColumnNames -> $cn {
                my $rcol = %localGenerators{$cn}($nrow);
                $cn => $rcol
            };

    # The generation above above was done per column,
    # so with transpose we get row-centric representation.
    my %hash-of-hashes = convert-to-hash-of-hashes(@dfRes);

    # Transpose the hash of hashes
    my %dfRes2;
    for %hash-of-hashes.values.first.keys X %hash-of-hashes.keys -> ($new-key, $current-key) {
        %dfRes2{$new-key}{$current-key} = %hash-of-hashes{$current-key}{$new-key};
    }

    ## Result
    if $row-names {
        # Row names

        # It is assumed that the row names are just integers and that the
        # following 0-padding does not introduce a significant performance penalty.
        # If it does, it can always be revered to just:
        #   %dfRes2.pairs.Array
        my Str $nd = ceiling(log10(%dfRes2.elems)).Str;
        %dfRes2.pairs.Array.map({ $_.key.Str.fmt('%0' ~ $nd ~ 'd') => $_.value }).Array

    } else {
        # No row names
        %dfRes2.map({ $_.value }).Array
    }
}