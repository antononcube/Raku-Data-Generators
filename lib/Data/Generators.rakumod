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
use Data::Generators::RandomVariate;
use Data::Generators::RandomTabularDataset;

unit module Data::Generators;

#===========================================================
#| Generate random strings.
our proto random-string(|) is export {*}

multi random-string(**@args, *%args) {
    Data::Generators::RandomFunctions::RandomString(|@args, |%args)
}

#===========================================================
#| Generate random words.
our proto random-word(|) is export {*}

multi random-word(**@args, *%args) {
    Data::Generators::RandomFunctions::RandomWord(|@args, |%args)
}

#===========================================================
#| Generate random pet names.
our proto random-pet-name(|) is export {*}

multi random-pet-name(**@args, *%args) {
    Data::Generators::RandomFunctions::RandomPetName(|@args, |%args)
}

#===========================================================
#| Generate random pretentious job titles.
our proto random-pretentious-job-title(|) is export {*}

multi random-pretentious-job-title(**@args, *%args) {
    Data::Generators::RandomFunctions::RandomPretentiousJobTitle(|@args, |%args)
}

#===========================================================
#| Gives a pseudorandom variate from the distribution specification.
our proto random-variate(|) is export {*}

multi random-variate(**@args, *%args) {
    Data::Generators::RandomVariate::RandomVariate(|@args, |%args)
}

#===========================================================
constant \NormalDistribution := Data::Generators::RandomVariate::NormalDistribution;
constant \UniformDistribution := Data::Generators::RandomVariate::UniformDistribution;

#===========================================================
#| Gives a pseudorandom variate from the uniform distribution with specified range.
our proto random-real(|) is export {*}

multi random-real(Numeric $max = 1) {
    return random-real((0, $max), 1)[0]
}

multi random-real(Numeric $max, UInt $size) {
    return random-real((0, $max), $size)
}

multi random-real(Numeric $max, @size) {
    return random-real((0, $max), @size)
}

multi random-real((Numeric $min, Numeric $max)) {
    return random-real(($min, $max), 1)[0];
}

multi random-real((Numeric $min, Numeric $max), UInt $size) {
    return Data::Generators::RandomVariate::RandomVariate(UniformDistribution.new(:$min, :$max), $size);
}

multi random-real((Numeric $min, Numeric $max), @size) {
    return Data::Generators::RandomVariate::RandomVariate(UniformDistribution.new(:$min, :$max), @size);
}

#===========================================================
#| Generate random tabular dataset.
our proto random-tabular-dataset(|) is export {*}

multi random-tabular-dataset(**@args, *%args) {
    Data::Generators::RandomTabularDataset::RandomTabularDataset(|@args, |%args)
}