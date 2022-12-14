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

multi random-real(Numeric :$min = 0, Numeric :$max = 1) {
    return random-real(($min, $max));
}

multi random-real(Numeric :$min = 0, Numeric :$max = 1, :$size = 1) {
    return random-real(($min, $max), $size);
}

#===========================================================
#| Generates a random date-time or a list of random date-times.
our proto random-date-time(|) is export {*}

constant $minDateTime = DateTime.new(year => 1900, month => 1, day => 1);
constant $maxDateTime = DateTime.new(year => 2100, month => 1, day => 1);


multi random-date-time((DateTime $min, DateTime $max)) {
    return random-date-time(:$min, :$max, size => Whatever);
}

multi random-date-time((DateTime $min = $minDateTime, DateTime $max = $maxDateTime), UInt $size = 1) {
    return random-date-time(:$min, :$max, :$size);
}

multi random-date-time(DateTime $max = $maxDateTime, $size = Whatever) {
    return random-date-time(min => $minDateTime, :$max, :$size);
}

multi random-date-time(DateTime :$min = $minDateTime, DateTime :$max = $maxDateTime, :$size = Whatever) {
    given $size {
        when $_.isa(Whatever) {
            return random-date-time(:$min, :$max, size => 1)[0];
        }
        when $_ ~~ Int && $_ > 0 {
            return (($max - $min).rand xx $size).map({ DateTime.new($_) }).List;
        }
        default {
            die 'The argument size is expected to be a positive integer or Whatever.';
        }
    }
}

#===========================================================
#| Generate random tabular dataset.
our proto random-tabular-dataset(|) is export {*}

multi random-tabular-dataset(**@args, *%args) {
    Data::Generators::RandomTabularDataset::RandomTabularDataset(|@args, |%args)
}