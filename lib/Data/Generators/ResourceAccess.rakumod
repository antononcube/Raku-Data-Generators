
class Data::Generators::ResourceAccess {
    ##========================================================
    ## Data
    ##========================================================
    my @englishWords;
    my %englishWords;
    my %typeToIndexes;
    my %specieToPetNames;

    ##========================================================
    ## BUILD
    ##========================================================
    # We create a lexical variable in the class block that holds our single instance.
    my Data::Generators::ResourceAccess $instance = Nil;

    my Int $numberOfInstances = 0;

    method getNumberOfInstances() {
        $numberOfInstances
    }

    my Int $numberOfMakeCalls = 0;

    method getNumberOfMakeCalls() {
        $numberOfMakeCalls
    }

    method new {!!!}

    submethod instance {

        $instance = Data::Generators::ResourceAccess.bless unless $instance;

        if $numberOfInstances == 0 {
            $instance.make()
        }

        $numberOfInstances += 1;

        $instance
    }

    method make() {
        $numberOfMakeCalls += 1;
        #say "Number of calls to .make $numberOfMakeCalls";

        #-----------------------------------------------------------
        my $fileName = %?RESOURCES{'dfEnglishWords.csv'};

        my $text = slurp $fileName.Str;
        @englishWords = $text.split("\n").map({ $_.split(',') });
        @englishWords = @englishWords[1..*-1];

        # Convert the logical fields into Booleans.
        my $k = 0;
        @englishWords = do for @englishWords -> $row {
            ( $row[0], $row[1] eq 'True', $row[2] eq 'True', $row[3] eq 'True', $k++)
        }

        # Make word data dictionary
        %englishWords = @englishWords.map({ $_[0] => $_ });

        # Create word type indexes
        %typeToIndexes =
                known => @englishWords.grep({ $_[1] }).map({ $_[4] }),
                common => @englishWords.grep({ $_[2]}).map({ $_[4] }),
                stopword => @englishWords.grep({ $_[3] }).map({ $_[4] });

        #-----------------------------------------------------------
        # Species Name Count
        $fileName = %?RESOURCES{'dfPetNameCounts.csv'};

        $text = slurp $fileName.Str;
        my @petNames = $text.split("\n").map({ $_.split('",').List });
        @petNames = @petNames[1..*-1];
        @petNames = @petNames.grep({ $_.elems == 3 });

        # Convert the count to integers.
        @petNames = do for @petNames -> $row {
            ( $row[0].substr(1,*), $row[1].substr(1,*), +$row[2])
        }

        # Make species to pet names dictionary
        %specieToPetNames = @petNames.classify({ $_[0] }).map({ $_.key.lc => Mix($_.value.map({ $_[1] => $_[2] })) });

        #-----------------------------------------------------------
        self
    }

    ##========================================================
    ## Access
    ##========================================================
    multi method get-word-data() {
        %englishWords
    }

    multi method get-word-data($word) {
        %englishWords{$word}
    }

    multi method get-random-word($size where $size ~~ UInt || $size.isa(Whatever),
                                 :&method = &roll
            --> List) {
        my @inds = &method($size, [^@englishWords.elems]);
        @englishWords[@inds].map({ $_[0] }).List
    }

    multi method get-random-word($size where * ~~ UInt || *.isa(Whatever),
                                 Str $type = 'known',
                                 :&method = &roll
            --> List) {
        my @inds = &method($size, %typeToIndexes{$type.lc}.cache);
        @englishWords[@inds].map({ $_[0] }).List
    }

    multi method get-random-pet-name($size where $size ~~ UInt || $size.isa(Whatever),
                                     Whatever,
                                     Bool :$weighted = False,
                                     :&method = &roll
            --> List) {
        if $size.isa(Whatever) {
            my @res = |%specieToPetNames.map({ $_.value.keys.pick(*) }).flat;
            return @res;
        }
        if $weighted {
            # Instead of joining all name-to-count hashes into one hash,
            # we sample each of them separately. Not a faithful way of sampling.
            return roll($size, %specieToPetNames.grep({ $_.key.lc ∈ <cat dog> }).map({ $_.value.roll($size) }).flat).List;
        } else {
            return &method($size, %specieToPetNames.map({ &method($size, $_.value.keys) }).flat).List;
        }
    }

    multi method get-random-pet-name($size where $size ~~ UInt || $size.isa(Whatever),
                                     Str $species,
                                     Bool :$weighted = False,
                                     :&method = &roll
            --> List) {
        if %specieToPetNames{$species.lc}:exists {
            if $weighted {
                %specieToPetNames{$species.lc}.roll($size).List;
            } else {
                &method($size, %specieToPetNames{$species.lc}.keys).List;
            }
        } else {
            warn "Unknown species $species.";
            ()
        }
    }
}
