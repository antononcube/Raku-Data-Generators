use Data::Generators::ResourceAccess;
my Data::Generators::ResourceAccess $resources.instance;

unit module Data::Generators::RandomWord;

#============================================================
our proto RandomWord(|) is export {*}

multi RandomWord(UInt $size = 1, :$type is copy = Whatever, Str :$language is copy = 'English' --> List) {

    if $size == 0 {
        die "The first argument is expected to be a positive integer."
    }

    if $type.isa(Whatever) { $type = 'any' }

    if not $type.isa(Str) {
        die "The argument type is expected to be one of 'any', 'common', 'known', 'stopword', or Whatever."
    }

    if $type.lc eq 'any' {
        $resources.get-random-word($size);
    } elsif $type.lc (elem) <known common> {
        $resources.get-random-word($size, $type.lc);
    } elsif $type.lc (elem) <stop stopword> {
        $resources.get-random-word($size, 'stopword');
    }
}