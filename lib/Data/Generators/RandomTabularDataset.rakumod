use Data::Generators::RandomVariate;
use Data::Generators::RandomFunctions;
use Data::Reshapers;

unit module Data::Generators::RandomTabularDataset;

#============================================================
sub is-positional-of-strings($vec) {
    ($vec ~~ Positional) and ($vec.all ~~ Str)
}

#============================================================
our sub RandomTabularDataset($nrow is copy,
                             $ncol is copy = Whatever,
                             :$columnNames is copy = Whatever,
                             :&columnNamesGenerator is copy = WhateverCode,
                             :$form is copy = "wide",
                             :$generators is copy = Whatever,
                             :$minNumberOfValues is copy = Whatever,
                             :$maxNumberOfValues is copy = Whatever,
                             Bool :$row-names = False) {

    # Process number of rows
    if $nrow.isa(Whatever) { $nrow = [1 ..^ 200].pick }
    if $nrow ~~ Numeric { $nrow .= Int }
    if not $nrow ~~ Int and $nrow > 0 {
        die "The argument nrow is expected to be positive integer or Whatever."
    }

    # Process number of columns
    my $localColumnNames = Whatever;
    if $columnNames.isa(Whatever) {
        if $ncol.isa(Whatever) { $ncol = [1 ..^ 30].pick }
    } elsif is-positional-of-strings($columnNames) {
        $localColumnNames = $columnNames;
        $ncol = $localColumnNames.elems;
    } else {
        die "The argument columnNames is expected to be a character vector or Whatever."
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