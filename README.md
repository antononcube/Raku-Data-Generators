# Raku Data::Generators

[![Actions Status](https://github.com/antononcube/Raku-Data-Generators/actions/workflows/linux.yml/badge.svg)](https://github.com/antononcube/Raku-Data-Generators/actions) 
[![Actions Status](https://github.com/antononcube/Raku-Data-Generators/actions/workflows/macos.yml/badge.svg)](https://github.com/antononcube/Raku-Data-Generators/actions) 
[![Actions Status](https://github.com/antononcube/Raku-Data-Generators/actions/workflows/windows.yml/badge.svg)](https://github.com/antononcube/Raku-Data-Generators/actions)

[![SparkyCI](http://ci.sparrowhub.io:/project/gh-antononcube-Raku-Data-Generators/badge)](http://ci.sparrowhub.io)
[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

This Raku package has functions for generating random strings, words, pet names, vectors, arrays, and
(tabular) datasets. 

### Motivation

The primary motivation for this package is to have simple, intuitively named functions
for generating random vectors (lists) and datasets of different objects.

Although, Raku has a fairly good support of random vector generation, it is assumed that commands
like the following are easier to use:

```{raku, eval = FALSE}
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```

------

## Random strings

The function `random-string` generates random strings.

Here is a random string:

```perl6
use Data::Generators;
random-string
```
```
# PWHH9azzayhU4kFqGg
```

Here we generate a vector of random strings with length 4 and characters that belong to specified ranges:

```perl6
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```
```
# ("y5Y7", "n75y", "2N1Y", "y782", "y143", "y523")
```

------

## Random words

The function `random-word` generates random words.

Here is a random word:

```perl6
random-word
```
```
# gearstick
```

Here we generate a list with 12 random words:

```perl6
random-word(12)
```
```
# (silky-haired Berlin horsemint Ariadne shlimazel oddments eater vain magneto camelia totaliser gelded)
```

Here we generate a table of random words of different types:

```perl6
use Data::Reshapers;
my @dfWords = do for <Any Common Known Stop> -> $wt { $wt => random-word(6, type => $wt) };
say to-pretty-table(@dfWords);
```
```
# +--------+---------+--------------+-------------+---------------+-----------+------------+
# |        |    4    |      5       |      0      |       2       |     1     |     3      |
# +--------+---------+--------------+-------------+---------------+-----------+------------+
# | Any    | portage |   copycat    | ladder-back |      p.m.     |  hahnium  |  Vanellus  |
# | Common |  galoot | youthfulness |    woman    | dependability | subsidize |  paganism  |
# | Known  |   lad   |  marketable  |   diarchy   |     kotow     |   tract   | diflunisal |
# | Stop   |    go   |     side     |     even    |      ever     |    but    |   since    |
# +--------+---------+--------------+-------------+---------------+-----------+------------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

**Remark:** The function `to-pretty-table` is from the package 
[Data::Reshapers](https://modules.raku.org/dist/Data::Reshapers:cpan:ANTONOV).

All word data can be retrieved with the resources object:

```perl6
my $ra = Data::Generators::ResourceAccess.instance();
$ra.get-word-data().elems;
```
```
# 84996
```


------

## Random pet names

The function `random-pet-name` generates random pet names.

The pet names are taken from publicly available data of pet license registrations in
the years 2015–2020 in Seattle, WA, USA. See [DG1].

Here is a random pet name:

```perl6
random-pet-name
```
```
# Prunella
```

The following command generates a list of six random pet names:

```perl6
srand(32);
random-pet-name(6).raku
```
```
# ("Tazman", "Bosun", "Sophie", "Belle", "Lily Bell", "Koda")
```

The named argument `species` can be used to specify specie of the random pet names. 
(According to the specie-name relationships in [DG1].)

Here we generate a table of random pet names of different species:

```perl6
my @dfPetNames = do for <Any Cat Dog Goat Pig> -> $wt { $wt => random-pet-name(6, species => $wt) };
say to-pretty-table(@dfPetNames);
```
```
# +------+---------+----------+----------+---------+--------+----------+
# |      |    0    |    1     |    4     |    3    |   5    |    2     |
# +------+---------+----------+----------+---------+--------+----------+
# | Any  |   Zoe   | Precious |  Tucker  |   Andy  | Honey  |   Tee    |
# | Cat  |  Petra  |   Moe    | Snickers |  Bella  | Storm  |   Boo    |
# | Dog  |  Logan  |  Renoir  |  Bodie   |  Snoopy |  Odin  |   Lupe   |
# | Goat |  Linda  |  Aggie   |  Sassy   |   Arya  | Grace  |  Margot  |
# | Pig  | Atticus | Guinness | Guinness | Atticus | Millie | Guinness |
# +------+---------+----------+----------+---------+--------+----------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

The named argument (adverb) `weighted` can be used to specify random pet name choice 
based on known real-life number of occurrences:

```perl6
srand(32);
say random-pet-name(6, :weighted).raku
```
```
# ("Smokey", "Sasha", "Bailey", "Scout", "Tazman", "Bosun")
```

The weights used correspond to the counts from [DG1].

**Remark:** The implementation of `random-pet-name` is based on the Mathematica implementation
[`RandomPetName`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPetName),
[AAf1].

All pet data can be retrieved with the resources object:

```perl6
my $ra = Data::Generators::ResourceAccess.instance();
$ra.get-pet-data()>>.elems
```
```
# {cat => 7806, dog => 12941, goat => 40, pig => 3}
```

------

## Random pretentious job titles

The function `random-pretentious-job-title` generates random pretentious job titles.

Here is a random pretentious job title:

```perl6
random-pretentious-job-title
```
```
# Corporate Security Representative
```

The following command generates a list of six random pretentious job titles:

```perl6
random-pretentious-job-title(6).raku
```
```
# ("Product Marketing Engineer", "Lead Resonance Developer", "Dynamic Factors Executive", "Customer Infrastructure Assistant", "Relational Functionality Coordinator", "Global Creative Coordinator")
```

The named argument `number-of-words` can be used to control the number of words in the generated job titles.

The named argument `language` can be used to control in which language the generated job titles are in.
At this point, only Bulgarian and English are supported.

Here we generate pretentious job titles using different languages and number of words per title:

```perl6
my $res = random-pretentious-job-title(12, number-of-words => Whatever, language => Whatever);
say ‌‌to-pretty-table($res.rotor(3));
```
```
# +-------------------------------+---------------------------+--------------------------------------------+
# |               0               |             1             |                     2                      |
# +-------------------------------+---------------------------+--------------------------------------------+
# |    Implementation Director    |          Producer         |                 Synergist                  |
# | Вътрешен Супервайзор на Мрежи | Клиентов Архитект по Идеи |             Markets Executive              |
# |         Representative        |   Супервайзор на Пазари   | Продукционен Супервайзор по Взаимодействия |
# |            Designer           |      Usability Agent      |            Плановик на Операции            |
# +-------------------------------+---------------------------+--------------------------------------------+
```

**Remark:** `Whatever` can be used as values for the named arguments `number-of-words` and `language`.

**Remark:** The implementation uses the job title phrases in https://www.bullshitjob.com . 
It is, more-or-less, based on the Mathematica implementation 
[`RandomPretentiousJobTitle`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPretentiousJobTitle),
[AAf2].

------

## Random reals

This module provides the function `random-real` that can be used to generate lists of real numbers
using the uniform distribution.

Here is a random real:

```perl6
say random-real(); 
```
```
# 0.8282274897974294
```

Here is a random real between 0 and 20:

```perl6
say random-real(20); 
```
```
# 2.6717214626314023
```

Here are six random reals between -2 and 12:

```perl6
say random-real([-2,12], 6);
```
```
# (-1.8834241515716836 3.8887615227122936 4.421996646763659 5.029791447935309 3.9707069201305067 8.70101978531368)
```

Here is a 4-by-3 array of random reals between -3 and 3:

```perl6
say random-real([-3,3], [4,3]);
```
```
# [[-0.12337305314623048 0.4655041255645993 -2.7557647476130733]
#  [0.7974770319715407 -1.832995933031438 0.3202246318412625]
#  [2.9875532284614845 1.5320938449458374 0.5738933740914449]
#  [-2.5329028582275743 -2.856925201204403 1.0881020860532775]]
```


**Remark:** The signature design follows Mathematica's function
[`RandomReal`](https://reference.wolfram.com/language/ref/RandomVariate.html).


------

## Random variates

This module provides the function `random-variate` that can be used to generate lists of real numbers
using distribution specifications.

Here are examples:

```perl6
say random-variate(NormalDistribution.new(:mean(10), :sd(20)), 5); 
```
```
# (-1.2890591546034695 -4.240194172291787 24.23729249700557 25.565384231319698 -31.42583501249206)
```

```perl6
say random-variate(NormalDistribution.new( µ => 10, σ => 20), 5); 
```
```
# (-24.970978206594808 27.580548932592283 4.293480947834469 53.78806606685142 -6.920372212762544)
```

```perl6
say random-variate(UniformDistribution.new(:min(2), :max(60)), 5);
```
```
# (49.4643635316776 56.74438883327643 35.769505371993986 21.8746551426201 33.80521073809191)
```

**Remark:** Only Normal distribution and Uniform distribution are implemented at this point.

**Remark:** The signature design follows Mathematica's function
[`RandomVariate`](https://reference.wolfram.com/language/ref/RandomVariate.html).

Here is an example of 2D array generation:

```perl6
say random-variate(NormalDistribution.new, [3,4]);
```
```
# [[-0.9171177150791677 0.010110377561891041 -0.7919263061829 0.83195200985803]
#  [-1.146863429854802 1.5201366101091918 -0.8916210526664188 1.369183790426792]
#  [-0.18450834272269118 -0.6844365153485313 -0.05756503431295109 -1.0883632144060866]]
```

------

## Random tabular datasets

The function `random-tabular-dataset` can be used generate tabular *datasets*.

**Remark:** In this module a *dataset* is (usually) an array of arrays of pairs.
The dataset data structure resembles closely Mathematica's data structure 
[`Dataset`]https://reference.wolfram.com/language/ref/Dataset.html), [WRI2]. 

**Remark:** The programming languages R and S have a data structure called "data frame" that
corresponds to dataset. (In the Python world the package `pandas` provides data frames.)
Data frames, though, are column-centric, not row-centric as datasets.
For example, data frames do not allow a column to have elements of heterogeneous types.

Here are basic calls:

```{perl6, eval=FALSE}
random-tabular-dataset();
random-tabular-dataset(Whatever):row-names;
random-tabular-dataset(Whatever, Whatever);
random-tabular-dataset(12, 4);
random-tabular-dataset(Whatever, 4);
random-tabular-dataset(Whatever, <Col1 Col2 Col3>):!row-names;
```

Here is example of a generated tabular dataset that column names that are cat pet names:

```perl6
my @dfRand = random-tabular-dataset(5, 3, column-names-generator => { random-pet-name($_, species => 'Cat') });
say to-pretty-table(@dfRand);
```
```
# +-----------+----------------------+------------+
# |  Chester  |        Marco         |    Skyy    |
# +-----------+----------------------+------------+
# | 39.290338 |        71Oi4         | Fouquieria |
# | 56.088575 |      FVNy6HE7C       |   snuff    |
# | 74.031581 | 3DKXzOZHOXamW7N4nTHm | raiseable  |
# | 10.407102 |        gKQMh         |  perform   |
# | 67.762760 |         Haw          | penetrator |
# +-----------+----------------------+------------+
```

The display function `to-pretty-table` is from
[`Data::Reshapers`](https://modules.raku.org/dist/Data::Reshapers:cpan:ANTONOV).

**Remark:** At this point only
[*wide format*](https://en.wikipedia.org/wiki/Wide_and_narrow_data)
datasets are generated. (The long format implementation is high in my TOOD list.)

**Remark:** The signature design and implementation are based on the Mathematica implementation
[`RandomTabularDataset`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomTabularDataset),
[AAf3].

------

## TODO

1. [ ] TODO Random tabular datasets generation
    - [X] DONE Row spec
    - [X] DONE Column spec that takes columns count and column names
    - [X] DONE Column names generator
    - [X] DONE Wide form implementation only
    - [X] DONE Generators of column values  
      - [X] DONE Column-generator hash
      - [X] DONE List of generators
      - [X] DONE Single generator
      - [X] DONE Turn "generators" that are lists into sampling pure functions
    - [ ] TODO Long form implementation
    - [ ] TODO Max number of values
    - [ ] TODO Min number of values
    - [ ] TODO Form (long or wide)
    - [X] DONE Row names (automatic)
    
2. [X] DONE Random reals vectors generation

3. [ ] TODO Figuring out how to handle and indicate missing values
   
4. [ ] TODO Random reals vectors generation according to distribution specs
    - [X] DONE Uniform distribution
    - [X] DONE Normal distribution
    - [ ] TODO Poisson distribution
    - [ ] TODO Skew-normal distribution
    - [ ] TODO Triangular distribution
    
5. [X] DONE `RandomReal`-like implementation 
    - See `random-real`.

6. [X] DONE Selection between `roll` and `pick` for:
    - [X] DONE `RandomWord`  
    - [X] DONE `RandomPetName`

------

## References

### Articles

[AA1] Anton Antonov,
["Pets licensing data analysis"](https://mathematicaforprediction.wordpress.com/2020/01/20/pets-licensing-data-analysis/), 
(2020), 
[MathematicaForPrediction at WordPress](https://mathematicaforprediction.wordpress.com).

### Functions, packages

[AAf1] Anton Antonov,
[RandomPetName](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPetName),
(2021),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository).

[AAf2] Anton Antonov,
[RandomPretentiousJobTitle](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPretentiousJobTitle),
(2021),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository).

[AAf3] Anton Antonov,
[RandomTabularDataset](https://resources.wolframcloud.com/FunctionRepository/resources/RandomTabularDataset),
(2021),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository).

[SHf1] Sander Huisman,
[RandomString](https://resources.wolframcloud.com/FunctionRepository/resources/RandomString),
(2021),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository).

[WRI1] Wolfram Research (2010), 
[RandomVariate](https://reference.wolfram.com/language/ref/RandomVariate.html), 
Wolfram Language function.

[WRI2] Wolfram Research (2014),
[Dataset](https://reference.wolfram.com/language/ref/Dataset.html),
Wolfram Language function.

### Data repositories

[DG1] Data.Gov,
[Seattle Pet Licenses](https://catalog.data.gov/dataset/seattle-pet-licenses),
[catalog.data.gov](https://catalog.data.gov).
