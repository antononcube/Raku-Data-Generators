# Raku Data::Generators

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
# b8GoL
```

Here we generate a vector of random strings with length 4 and characters that belong to specified ranges:

```perl6
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```
```
# ("3809", "6N1N", "n20Y", "9818", "70n4", "n803")
```

------

## Random words

The function `random-word` generates random words.

Here is a random word:

```perl6
random-word
```
```
# paunchy
```

Here we generate a list with 12 random words:

```perl6
random-word(12)
```
```
# (competitor nonvolatile wryly pontifex lycaenid pintail raging disappoint medicinally licentiousness fathom deerstalker)
```

Here we generate a table of random words of different types:

```perl6
use Data::Reshapers;
my @dfWords = do for <Any Common Known Stop> -> $wt { $wt => random-word(6, type => $wt) };
say to-pretty-table(@dfWords);
```
```
# +--------+----------------+-----------+--------------------+----------+-------------+------------+
# |        |       1        |     3     |         4          |    0     |      5      |     2      |
# +--------+----------------+-----------+--------------------+----------+-------------+------------+
# | Any    |   superable    |   adduct  | Saint-John's-bread | inweave  | offenseless | well-known |
# | Common | reconstruction |  quelled  |      primacy       | quarrel  |    warty    | quadrangle |
# | Known  |     roble      | herbalist |       jihad        | outdated |   turnout   | emanation  |
# | Stop   |       an       |    many   |      seeming       |   not    |   doesn't   |  further   |
# +--------+----------------+-----------+--------------------+----------+-------------+------------+
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
# Mia
```

The following command generates a list of six random pet names:

```perl6
srand(32);
random-pet-name(6).raku
```
```
# ("Sakura", "Rosie", "Butch", "Juno", "Jack", "Lucky Joe")
```

The named argument `species` can be used to specify specie of the random pet names. 
(According to the specie-name relationships in [DG1].)

Here we generate a table of random pet names of different species:

```perl6
my @dfPetNames = do for <Any Cat Dog Goat Pig> -> $wt { $wt => random-pet-name(6, species => $wt) };
say to-pretty-table(@dfPetNames);
```
```
# +------+------------+--------+----------+---------+----------+----------+
# |      |     5      |   1    |    3     |    0    |    2     |    4     |
# +------+------------+--------+----------+---------+----------+----------+
# | Any  |   Sasha    | Rolie  |  Isaac   |   Ayla  | Midnight |  Bilbo   |
# | Cat  | Poppy Seed | Mollee | Hermione |  Tilly  | Charlie  |  Hermey  |
# | Dog  |   Lacey    | Shadow |   Xena   |  Sasha  |  Leela   |  Maxie   |
# | Goat |  Winnipeg  |  Lula  |  Linda   | Phyllis |  Sassy   |   Arya   |
# | Pig  |  Guinness  | Millie |  Millie  |  Millie |  Millie  | Guinness |
# +------+------------+--------+----------+---------+----------+----------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

The named argument (adverb) `weighted` can be used to specify random pet name choice 
based on known real-life number of occurrences:

```perl6
srand(32);
say random-pet-name(6, :weighted).raku
```
```
# ("Milo", "Django", "Kiera", "Remi Wintour", "Sakura", "Rosie")
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
# Global Tactics Officer
```

The following command generates a list of six random pretentious job titles:

```perl6
random-pretentious-job-title(6).raku
```
```
# ("Dynamic Configuration Assistant", "Customer Paradigm Consultant", "Dynamic Metrics Orchestrator", "Corporate Integration Liason", "Lead Factors Planner", "Internal Infrastructure Orchestrator")
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
# +-----------------------+---------------------------------+------------------------+
# |           0           |                1                |           2            |
# +-----------------------+---------------------------------+------------------------+
# |       Associate       |           Facilitator           |   Solutions Planner    |
# |  Инженер по Отговори  |      Functionality Engineer     | Проектант на Сигурност |
# | Консултант на Фактори |       Team Representative       |       Developer        |
# |   Ideation Associate  | Международен Синергист на Екипи |        Директор        |
# +-----------------------+---------------------------------+------------------------+
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
# 0.9716856978053211
```

Here is a random real between 0 and 20:

```perl6
say random-real(20); 
```
```
# 3.6560991452680636
```

Here are six random reals between -2 and 12:

```perl6
say random-real([-2,12], 6);
```
```
# (4.487327134878258 7.24396064493283 4.335366288703926 0.7274527157480799 1.1610012779782908 4.209077109332537)
```

Here is a 4-by-3 array of random reals between -3 and 3:

```perl6
say random-real([-3,3], [4,3]);
```
```
# [[2.3456827624455796 1.211610170085196 1.2154224776343723]
#  [-0.6001512765795969 2.1083429736973525 0.003666225776507659]
#  [-2.999605183797774 -1.7792500324033755 0.35511117994116237]
#  [-0.31777833103604314 -2.200688319175871 2.0764346644911855]]
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
# (1.5361159008155685 48.9608536164365 -10.143915989821487 29.211835362955828 -3.3874436230947698)
```

```perl6
say random-variate(NormalDistribution.new( µ => 10, σ => 20), 5); 
```
```
# (3.458954986958796 1.325219423487571 9.178917445625153 21.495702892542845 -17.485588393485173)
```

```perl6
say random-variate(UniformDistribution.new(:min(2), :max(60)), 5);
```
```
# (33.66071105322739 3.056977956006511 7.189165514877061 24.664339577273235 57.021358346513956)
```

**Remark:** Only Normal distribution and Uniform distribution are implemented at this point.

**Remark:** The signature design follows Mathematica's function
[`RandomVariate`](https://reference.wolfram.com/language/ref/RandomVariate.html).

Here is an example of 2D array generation:

```perl6
say random-variate(NormalDistribution.new, [3,4]);
```
```
# [[-1.362412861209989 0.0021731911912484044 -1.4929303574028636 0.28678297441314793]
#  [-0.40152611847354835 0.7217405261312951 0.47118518345990706 -0.77214220582723]
#  [-1.5856914640909907 0.479642411665097 0.2233627474776211 -0.8156297626961373]]
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
# +-----------+-----------+-----------+
# |    Rudy   |    Finn   |    Arlo   |
# +-----------+-----------+-----------+
# | 63.094711 | 24.948158 | 30.453565 |
# | 70.918013 |  9.676955 | 35.066645 |
# | 92.131223 | 18.315310 |  0.909908 |
# | 23.151258 |  1.712041 | 24.321017 |
# | 85.557734 |  5.530377 | 18.753154 |
# +-----------+-----------+-----------+
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
