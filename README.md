# Raku Data::Generators

[![Build Status](https://app.travis-ci.com/antononcube/Raku-Data-Generators.svg?branch=main)](https://app.travis-ci.com/github/antononcube/Raku-Data-Generators)
[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

This Raku package has functions for generating random strings, words, pet names, vectors, and
(tabular) datasets. 

### Motivation

The primary motivation fo this package is to have simple, intuitively named functions
for generating random vectors (lists) and datasets of different objects.

Although, Raku has fairly good support of random vector generation, it is assumed that commands
like this one are easier to use:

```{raku, eval = FALSE}
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```

------

## Random string

The function `random-string` generates random strings.

Here we generate a vector of random strings with length 4 and characters that belong to specified ranges:

```raku
use Data::Generators;
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```
```
# ("Y7y3", "43n4", "N9Y6", "603n", "701Y", "7631")
```

------

## Random word

The function `random-word` generates random words.

Here we generate a list with 12 random words:

```raku
random-word(12)
```
```
# (wily Monterrey Skagerak Duse barrelled rumor rum forty-third Dermoptera maltster Schoolcraft homunculus)
```

Here we generate a table of random words of different types:

```raku
use Data::Reshapers;
my @dfWords = do for <Any Common Known Stop> -> $wt { $wt => random-word(6, type => $wt) };
say to-pretty-table(@dfWords);
```
```
# +--------+--------------+----------------+----------------+-----------------+-------------+--------------+
# |        |      3       |       0        |       1        |        4        |      2      |      5       |
# +--------+--------------+----------------+----------------+-----------------+-------------+--------------+
# | Any    |   tangibly   |   Phaeophyta   |   encephalon   | cross-pollinate | gallbladder | off-Broadway |
# | Common |     yam      |    waltzer     |      swot      |    procedural   |    family   |   esteemed   |
# | Known  | noncombining | smooth-shelled | neocolonialism |   overreaching  |   bistroic  |  disprover   |
# | Stop   |     are      |    yourself    |     doing      |      while      |  everything |    always    |
# +--------+--------------+----------------+----------------+-----------------+-------------+--------------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

**Remark:** The function `to-pretty-table` is from the package 
[Data::Reshapers](https://modules.raku.org/dist/Data::Reshapers:cpan:ANTONOV).

------

## Random pet names

The function `random-pet-name` generates random pet names.

The pet names are taken from publicly available data of pet license registrations in
the years 2015–2020 in Seattle, WA, USA. See [DG1].

The following command generates a list of six random pet names:

```raku
srand(32);
random-pet-name(6).raku
```
```
# ("Shimano", "Guanyin", "Truffle", "Finnegan", "Fiona", "Finnegan")
```

The named argument `species` can be used to specify specie of the random pet names. 
(According to the specie-name relationships in [DG1].)

Here we generate a table of random pet names of different species:

```raku
my @dfPetNames = do for <Any Cat Dog Goat Pig> -> $wt { $wt => random-pet-name(6, species => $wt) };
say to-pretty-table(@dfPetNames);
```
```
# +------+---------+------------+------------+-----------+----------+------------------------------+
# |      |    4    |     2      |     3      |     1     |    5     |              0               |
# +------+---------+------------+------------+-----------+----------+------------------------------+
# | Any  | Atticus |   Millie   |  Santino   |  Atticus  | Tuppence |           Guinness           |
# | Cat  |  Kanga  | Wooly Bear |   Rylee    |  Mahalia  |  Citra   | Felix Felicis the Invincible |
# | Dog  |  Keita  |   Saffy    | Browne Lei | Frankford |  Bewley  |          Emmie Lou           |
# | Goat |  Frosty |   Linda    |    Tati    |  Estelle  | Winnipeg |             Lula             |
# | Pig  |  Millie |   Millie   |  Guinness  |  Guinness | Atticus  |            Millie            |
# +------+---------+------------+------------+-----------+----------+------------------------------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

The named argument (adverb) `weighted` can be used to specify random pet name choice 
based on known real-life number of occurrences:

```raku
srand(32);
say ‌‌random-pet-name(6, :weighted).raku
```
```
# ("Seigfried", "Guinness", "Leena", "Poet", "Cutter", "Sammy Sandwich")
```

The weights used correspond to the counts from [DG1].

**Remark:** The implementation of `random-pet-name` is based on the Mathematica implementation
[`RandomPetName`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPetName),
[AAf1].

------

## Random pretentious job titles

The function `random-pretentious-job-title` generates random pretentious job titles.

The following command generates a list of six random pretentious job titles:

```raku
random-pretentious-job-title(6).raku
```
```
# ("International Paradigm Manager", "National Security Planner", "Forward Response Associate", "Global Marketing Executive", "Interactive Tactics Strategist", "Dynamic Marketing Representative")
```

The named argument `number-of-words` can be used to control the number of words in the generated job titles.

The named argument `language` can be used to control in which language the generated job titles are in.
At this point, only Bulgarian and English are supported.

Here we generate pretentious job titles using different languages and number of words per title:

```raku
my $res = random-pretentious-job-title(12, number-of-words => Whatever, language => Whatever);
say ‌‌to-pretty-table($res.rotor(3));
```
```
# +-------------------------+-----------------------------+-------------------+
# |            0            |              1              |         2         |
# +-------------------------+-----------------------------+-------------------+
# |  Optimization Associate |         Разработчик         |     Проектант     |
# |    Стратег на Пазари    |   Functionality Architect   |     Проектант     |
# |         Designer        | Продуцент по Взаимодействия | Tactics Associate |
# | Изпълнител по Прилагане |           Producer          |      Директор     |
# +-------------------------+-----------------------------+-------------------+
```

**Remark:** `Whatever` can be used as values for the named arguments `number-of-words` and `language`.

**Remark:** The implementation uses the job title phrases in https://www.bullshitjob.com . 
It is, more-or-less, based on the Mathematica implementation 
[`RandomPretentiousJobTitle`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPretentiousJobTitle),
[AAf2].

------

## Random reals

This module provides the function `random-variate` that can be used to generate list of real numbers
using distribution specifications.


```perl6
say random-variate(NormalDistribution.new(:mean(10), :sd(20)), 5);
say random-variate(UniformDistribution.new(:min(2), :max(60)), 5);
```
```
# (-13.466696350435114 -3.111138101582986 -21.247001944906305 -21.944304322628078 -10.974630024828294)
# (10.855215562606944 47.22657266404291 33.471243161398974 2.955369198643181 49.942812257264976)
```

**Remark:** The signature design follows Mathematica's function 
[`RandomVariate`](https://reference.wolfram.com/language/ref/RandomVariate.html).

**Remark:** Only Normal distribution and Uniform distribution are implemented at this point.

------

## Random tabular dataset

The function `random-tabular-dataset` can be used make tabular *datasets* --
i.e. array of arrays of pairs.

Here are basic calls:

```{perl6, eval=FALSE}
random-tabular-dataset();
random-tabular-dataset(Whatever):row-names;
random-tabular-dataset(Whatever, Whatever);
random-tabular-dataset(12, 4);
random-tabular-dataset(Whatever, 4);
random-tabular-dataset(Whatever, <Col1 Col2 Col3>):!row-names;
```

Here is example of a generated displayed with `to-pretty-table` from 
[`Data::Reshapers`](https://modules.raku.org/dist/Data::Reshapers:cpan:ANTONOV):

```perl6
my @dfRand = random-tabular-dataset(5, 3, column-names-generator => { random-pet-name($_, species => 'Cat') });
say to-pretty-table(@dfRand);
```
```
# +---------------+--------------------+--------------+
# |     Mystic    |      Birgitta      |  Snowbelle   |
# +---------------+--------------------+--------------+
# | well-mannered | 148.48346874595433 | phagocytosis |
# |   alfilaria   | 111.96827462410418 | conscription |
# |     Gibbs     | 109.27365413469518 | long-snouted |
# |   stalactite  | 103.06860304957846 |  embrittle   |
# |    ayapana    | 99.20717938118923  |   mercury    |
# +---------------+--------------------+--------------+
```

**Remark:** At this point only
[*wide format*](https://en.wikipedia.org/wiki/Wide_and_narrow_data)
datasets are generated. (The long format implementation is high in my TOOD list.)

**Remark:** The signature design and implementation are based on the Mathematica implementation
[`RandomTabularDataset`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomTabularDataset),
[AAf3].

------

## TODO

1. [ ] Random tabular datasets generation
    - [X] Row spec
    - [X] Column spec that takes columns count and column names
    - [X] Column names generator
    - [X] Wide form implementation only
    - [ ] Long form implementation  
    - [ ] Generators of column values  
    - [ ] Max number of values
    - [ ] Min number of values
    - [ ] Form (long or wide)
    - [X] Row names (automatic)
    
2. [X] Random reals vectors generation

3. [ ] Figuring out how to handle and indicate missing values
   
4. [ ] Random reals vectors generation according to distribution specs
    - [X] Uniform distribution
    - [X] Normal distribution
    - [ ] Poisson distribution
    - [ ] Skew-normal distribution
    - [ ] Triangular distribution

5. [ ] Selection between `roll` and `pick` for:
    - [ ] `RandomWord`  
    - [ ] `RandomPetName`

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

### Data repositories

[DG1] Data.Gov,
[Seattle Pet Licenses](https://catalog.data.gov/dataset/seattle-pet-licenses),
[catalog.data.gov](https://catalog.data.gov).
