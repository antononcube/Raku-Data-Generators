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
                           :&columnNamesGenerator is copy = WhateverCode,
                           :$form is copy = "wide",
                           :$generators is copy = Whatever,
                           :$minNumberOfValues is copy = Whatever,
                           :$maxNumberOfValues is copy = Whatever,
                           Bool :$row-names = False) {

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
        die "The second, columns specifictions argument is expected to be a positive interger, a list of strings, or Whatever."
    }

    # Column names generator
    if $localColumnNames.isa(Whatever) {
        if &columnNamesGenerator.isa(WhateverCode) {
            $localColumnNames = RandomWord($ncol, type => 'Common')
        } else {
            $localColumnNames = &columnNamesGenerator($ncol)
        }
    }

    # Generators


    ## Max Number Of Values
    if $maxNumberOfValues.isa(Whatever) {
        $maxNumberOfValues = $nrow * $ncol
    }

    if not $maxNumberOfValues ~~ Numeric and $maxNumberOfValues > 0 {
        die "The argument maxNumberOfValues is expected to be a non-negative integer or Whatever."
    }

    ## Min Number Of Values
    if $maxNumberOfValues.isa(Whatever) {
        $maxNumberOfValues = $nrow * $ncol
    }

    if not $maxNumberOfValues ~~ Numeric and $maxNumberOfValues > 0 {
        die "The argument maxNumberOfValues is expected to be a non-negative integer or Whatever."
    }

    ## Form
    if $form.isa(Whatever) { $form = Mix(long => 0.3, wide => 0.7).pick }

    if not $form ~~ Str and $form.lc (elem) <Long Wide>.lc {
        warn "The argument form is expected to be NULL or one of 'Long' or 'Wide'. Continuing using 'Wide'.";
        $form = "wide"
    }

    $form = $form.lc;

    # Generate random values
    my @dfRes =
            do for $localColumnNames.List -> $cn {
                my $rcol =
                        rand > 0.5 ??
                        RandomWord($nrow) !!
                        RandomVariate(NormalDistribution.new(mean => 100, sd => 20), $nrow);
                $cn => $rcol
            };

    @dfRes = transpose(@dfRes);

    ## Result
    if not $row-names {
        # No row names
        @dfRes.map({ $_.value })
    } else {
        # Row names
        @dfRes
    }
}