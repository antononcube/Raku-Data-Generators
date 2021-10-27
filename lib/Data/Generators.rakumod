=begin pod

=head1 Data::Generators

C<Data::Generators> package has data generation functions for
random words, pretentious job titles.

=head1 Synopsis

    use Data::Generators;

    say random-word(6);
    say random-word(6, type => 'known');
    say random-pretentious-job-title(4)
    say random-pretentious-job-title(4, language => 'Bulgarian')

=end pod

use Data::Generators::RandomFunctions;

unit module Data::Generators;

#===========================================================
#| Generate random strings.
our proto random-string(|) is export {*}

multi random-string( **@args, *%args  --> List) {
    Data::Generators::RandomFunctions::RandomString( |@args, |%args )
}

#===========================================================
#| Generate random words.
our proto random-word(|) is export {*}

multi random-word( **@args, *%args  --> List) {
    Data::Generators::RandomFunctions::RandomWord( |@args, |%args )
}

#===========================================================
#| Generate random pet names.
our proto random-pet-name(|) is export {*}

multi random-pet-name( **@args, *%args --> List) {
    Data::Generators::RandomFunctions::RandomPetName( |@args, |%args )
}

#===========================================================
#| Generate random pretentious job titles.
our proto random-pretentious-job-title(|) is export {*}

multi random-pretentious-job-title( **@args, *%args --> List) {
    Data::Generators::RandomFunctions::RandomPretentiousJobTitle( |@args, |%args )
}