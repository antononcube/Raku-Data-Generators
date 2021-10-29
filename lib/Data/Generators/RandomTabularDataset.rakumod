use Data::Generators::RandomVariate;
use Data::Generators::RandomFunctions;
use Data::Reshapers;

unit module Data::Generators::RandomTabularDataset;

#============================================================
sub is-positional-of-strings($vec) {
    ($vec ~~ Positional) and ($vec.all ~~ Str)
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
        die "The argument nrow is expected to be positive integer or Whatever."
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
        die "The second, columns specifiction argument is expected to be a positive interger, a list of strings, or Whatever."
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


    ## Max Number Of Values
    if $max-number-of-values.isa(Whatever) {
        $max-number-of-values = $nrow * $ncol
    }

    if not $max-number-of-values ~~ Numeric and $max-number-of-values > 0 {
        die "The argument maxNumberOfValues is expected to be a non-negative integer or Whatever."
    }

    ## Min Number Of Values
    if $min-number-of-values.isa(Whatever) {
        $min-number-of-values = $nrow * $ncol
    }

    if not $min-number-of-values ~~ Numeric and $min-number-of-values > 0 {
        die "The argument minNumberOfValues is expected to be a non-negative integer or Whatever."
    }

    ## Form
    if $form.isa(Whatever) { $form = Mix(long => 0.3, wide => 0.7).pick }

    if not $form ~~ Str and $form.lc (elem) <Long Wide>.lc {
        warn "The argument form is expected to be NULL or one of 'Long' or 'Wide'. Continuing using 'Wide'.";
        $form = "wide"
    }

    $form = $form.lc;

    # Generate random values
    my @dfRes is Array =
            do for $localColumnNames.List -> $cn {
                my $rcol =
                        rand > 0.5 ??
                        RandomWord($nrow) !!
                        RandomVariate(NormalDistribution.new(mean => 100, sd => 20), $nrow);
                $cn => $rcol
            };

    # The generation above above was done per column,
    # so with transpose we get row-centric representation.
    @dfRes = transpose(@dfRes);

    ## Result
    if $row-names {
        # Row names
        @dfRes
    } else {
        # No row names
        # This assumes that Data::Reshapers::transpose returns an array of key-to-hash pairs.
        @dfRes.map({ $_.value }).Array
    }
}