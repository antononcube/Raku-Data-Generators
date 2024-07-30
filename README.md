# Raku Data::Generators

[![Actions Status](https://github.com/antononcube/Raku-Data-Generators/actions/workflows/linux.yml/badge.svg)](https://github.com/antononcube/Raku-Data-Generators/actions) 
[![Actions Status](https://github.com/antononcube/Raku-Data-Generators/actions/workflows/macos.yml/badge.svg)](https://github.com/antononcube/Raku-Data-Generators/actions) 
[![Actions Status](https://github.com/antononcube/Raku-Data-Generators/actions/workflows/windows.yml/badge.svg)](https://github.com/antononcube/Raku-Data-Generators/actions)

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
# rNa0FuC75aoA
```

Here we generate a vector of random strings with length 4 and characters that belong to specified ranges:

```perl6
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```
```
# ("333N", "5N1y", "n0Y7", "7085", "6502", "y0Y7")
```

------

## Random words

The function `random-word` generates random words.

Here is a random word:

```perl6
random-word
```
```
# psychopathy
```

Here we generate a list with 12 random words:

```perl6
random-word(12)
```
```
# (drive-in joyless opportunistic kalian fertilize barium Malawian dingy reprobate wannabe penitential compaction)
```

Here we generate a table of random words of different types:

```perl6
use Data::Reshapers;
my @dfWords = do for <Any Common Known Stop> -> $wt { $wt => random-word(6, type => $wt) };
say to-pretty-table(@dfWords);
```
```
# +--------+---------------+---------+-----------+----------------+-------------+--------------+
# |        |       4       |    0    |     2     |       3        |      5      |      1       |
# +--------+---------------+---------+-----------+----------------+-------------+--------------+
# | Any    | Anoectochilus |  coltan | parhelion |  heartburning  | therewithal | columniation |
# | Common |    explicit   | beastly |   cycle   | overindulgence |  extenuate  |   anaphora   |
# | Known  |   spiritism   | talaria |  feeling  |     grapy      |     guru    |    epigon    |
# | Stop   |       a       |   i've  |     0     |   shouldn't    |      X      |     few      |
# +--------+---------------+---------+-----------+----------------+-------------+--------------+
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
# Murphy
```

The following command generates a list of six random pet names:

```perl6
srand(32);
random-pet-name(6).raku
```
```
# ("Zoe", "Bandit", "Cody", "Barb", "Barack", "Cooper")
```

The named argument `species` can be used to specify specie of the random pet names. 
(According to the specie-name relationships in [DG1].)

Here we generate a table of random pet names of different species:

```perl6
my @dfPetNames = do for <Any Cat Dog Goat Pig> -> $wt { $wt => random-pet-name(6, species => $wt) };
say to-pretty-table(@dfPetNames);
```
```
# +------+----------+------------------+----------+---------+----------+---------+
# |      |    0     |        1         |    2     |    4    |    5     |    3    |
# +------+----------+------------------+----------+---------+----------+---------+
# | Any  | Hamilton | Tyson Zeus Brown | Georgia  |   Ivy   |  Mochi   |  Ellla  |
# | Cat  |   Ace    |      Felix       |   Dean   | Georgia | Little B |   Lulu  |
# | Dog  |  Louis   |      Wiley       |   Moya   |   Cleo  | Barkley  |  Buster |
# | Goat | Grayson  |     Junebug      | Winnipeg |   Lula  | Abelard  |  Grace  |
# | Pig  | Atticus  |     Atticus      |  Millie  | Atticus | Atticus  | Atticus |
# +------+----------+------------------+----------+---------+----------+---------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

The named argument (adverb) `weighted` can be used to specify random pet name choice 
based on known real-life number of occurrences:

```perl6
srand(32);
say random-pet-name(6, :weighted).raku
```
```
# ("Claire", "Ilsa", "Tinkerbelle", "Remy", "Zoe", "Bandit")
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
# Direct Functionality Director
```

The following command generates a list of six random pretentious job titles:

```perl6
random-pretentious-job-title(6).raku
```
```
# ("Central Data Agent", "National Team Executive", "Corporate Infrastructure Associate", "Global Accountability Agent", "National Metrics Agent", "Future Mobility Planner")
```

The named argument `number-of-words` can be used to control the number of words in the generated job titles.

The named argument `language` can be used to control in which language the generated job titles are in.
At this point, only Bulgarian and English are supported.

Here we generate pretentious job titles using different languages and number of words per title:

```perl6
my $res = random-pretentious-job-title(12, number-of-words => Whatever, language => Whatever);
say to-pretty-table($res.rotor(3));
```
```
# +---------------------------+----------------------------------+----------------------------------+
# |             0             |                1                 |                2                 |
# +---------------------------+----------------------------------+----------------------------------+
# |         Specialist        |          Администратор           |        Response Executive        |
# |   Optimization Designer   |     Супервайзор по Маркетинг     | Interactive Applications Manager |
# | Future Response Associate |         Brand Technician         |      Посредник на Качество       |
# |   Identity Administrator  | Глобален Специалист на Отчетност |       Integration Designer       |
# +---------------------------+----------------------------------+----------------------------------+
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
# 0.6148375015300324
```

Here is a random real between 0 and 20:

```perl6
say random-real(20); 
```
```
# 13.957487542046149
```

Here are six random reals between -2 and 12:

```perl6
say random-real([-2,12], 6);
```
```
# (-1.4191627349160865 0.7985910676295189 2.5735598216113056 8.655772458122875 -0.23141703578666983 3.2473529322039427)
```

Here is a 4-by-3 array of random reals between -3 and 3:

```perl6
say random-real([-3,3], [4,3]);
```
```
# [[-0.7777530943688706 2.633038558227515 0.9960527665422672]
#  [0.5438581449111846 0.8538444340370224 -1.2232218597405276]
#  [0.24844626265222436 1.6176949918194392 -2.9106836929578517]
#  [-1.1519301602208225 -2.168108140257122 1.575345624009456]]
```


**Remark:** The signature design follows Mathematica's function
[`RandomReal`](https://reference.wolfram.com/language/ref/RandomVariate.html).


------

## Random variates

This module provides the function `random-variate` that can be used to generate lists of real numbers
using distribution specifications.

Here are examples:

```perl6
say random-variate(BernoulliDistribution.new(:p(0.3)), 1000).BagHash.Hash; 
```
```
# {0 => 683, 1 => 317}
```

```perl6
say random-variate(BinomialDistribution.new(:n(10), :p(0.2)), 10); 
```
```
# (2 2 4 1 2 2 4 2 1 2)
```

```perl6
say random-variate(NormalDistribution.new( µ => 10, σ => 20), 5); 
```
```
# (-1.0372379191539256 15.88117685892444 2.3800289134125467 -16.077914554672056 21.434725308461598)
```

```perl6
say random-variate(UniformDistribution.new(:min(2), :max(60)), 5);
```
```
# (33.12620384207506 54.54682825992015 44.703052532365824 18.662929703538268 16.99790622594807)
```

**Remark:** Only Normal distribution and Uniform distribution are implemented at this point.

**Remark:** The signature design follows Mathematica's function
[`RandomVariate`](https://reference.wolfram.com/language/ref/RandomVariate.html).

Here is an example of 2D array generation:

```perl6
say random-variate(NormalDistribution.new, [3,4]);
```
```
# [[1.730441181600127 0.3420465932875971 -0.6275231817898077 0.7933012580974133]
#  [0.7546145800662779 -0.1414053357058038 0.06128413616858158 -0.48630656184266835]
#  [-0.8339285130645827 -3.0312240538258073 0.18147829328498447 1.1150963106600722]]
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
# +-----------+-----------+---------------+
# |   Tonks   |   Bailey  |    Skipper    |
# +-----------+-----------+---------------+
# | -0.425523 | 14.708426 |   extirpate   |
# | 25.249457 |  4.334753 |    humanize   |
# | 23.518357 |  9.309680 |    eccyesis   |
# |  5.089616 | 20.839470 |   prevailing  |
# | 17.328699 | 11.818831 | irreligionist |
# +-----------+-----------+---------------+
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
