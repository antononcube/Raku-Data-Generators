# Raku Data::Generators

[![SparkyCI](http://sparrowhub.io:2222/project/gh-antononcube-Raku-Data-Generators/badge)](http://sparrowhub.io:2222)
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
# eM
```

Here we generate a vector of random strings with length 4 and characters that belong to specified ranges:

```raku
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```
```
# ("0n57", "n489", "0yn5", "8Y84", "0n83", "7Y2Y")
```

------

## Random words

The function `random-word` generates random words.

Here is a random word:

```perl6
random-word
```
```
# mayfly
```

Here we generate a list with 12 random words:

```raku
random-word(12)
```
```
# (77 implantation Vespasian Porphyrula rainfly unhorse periphrastic stabilize milestone thorniness chat uniparous)
```

Here we generate a table of random words of different types:

```raku
use Data::Reshapers;
my @dfWords = do for <Any Common Known Stop> -> $wt { $wt => random-word(6, type => $wt) };
say to-pretty-table(@dfWords);
```
```
# +--------+-----------+----------+------------+-------------+-----------+----------+
# |        |     2     |    4     |     5      |      3      |     1     |    0     |
# +--------+-----------+----------+------------+-------------+-----------+----------+
# | Any    | logomania |  matzah  |  Bemidji   |    Elspar   |    chon   | haloform |
# | Common |  mantissa | hookworm |  ungainly  |   sneaker   |   ferry   | clematis |
# | Known  |    owl    | tripling | canecutter | merchantman | inclusive | doglike  |
# | Stop   |   while   |  you're  |    him     |     how     |   always  |  wasn't  |
# +--------+-----------+----------+------------+-------------+-----------+----------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

**Remark:** The function `to-pretty-table` is from the package 
[Data::Reshapers](https://modules.raku.org/dist/Data::Reshapers:cpan:ANTONOV).

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
# Kili
```

The following command generates a list of six random pet names:

```raku
srand(32);
random-pet-name(6).raku
```
```
# ("Luther", "Millie", "Guinness", "Luther", "Professor Nibblesworth", "Atticus")
```

The named argument `species` can be used to specify specie of the random pet names. 
(According to the specie-name relationships in [DG1].)

Here we generate a table of random pet names of different species:

```raku
my @dfPetNames = do for <Any Cat Dog Goat Pig> -> $wt { $wt => random-pet-name(6, species => $wt) };
say to-pretty-table(@dfPetNames);
```
```
# +------+----------+-----------------+--------------+------------------------+---------+----------+
# |      |    4     |        2        |      0       |           1            |    5    |    3     |
# +------+----------+-----------------+--------------+------------------------+---------+----------+
# | Any  | Atticus  |     Guinness    |    Winnie    |         Rocket         |  Beans  |  Aggie   |
# | Cat  | Josefina |    Meow-Meow    | Parker Posey |   Katherine Hepburn    |  Chaco  | Mow Mow  |
# | Dog  | Minotaur |     Sputnik     |     Navy     |   Melian (mel-ee-un)   |  Draco  | Skidster |
# | Goat |  Grace   | Brussels Sprout |   Schmidt    | Professor Nibblesworth |  Darcy  |  Piper   |
# | Pig  |  Millie  |     Atticus     |    Millie    |         Millie         | Atticus | Guinness |
# +------+----------+-----------------+--------------+------------------------+---------+----------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

The named argument (adverb) `weighted` can be used to specify random pet name choice 
based on known real-life number of occurrences:

```raku
srand(32);
say random-pet-name(6, :weighted).raku
```
```
# ("Millie", "Audrey Carroll Buchbinder Chia", "Moppet", "Millie", "Linda", "Linda")
```

The weights used correspond to the counts from [DG1].

**Remark:** The implementation of `random-pet-name` is based on the Mathematica implementation
[`RandomPetName`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPetName),
[AAf1].

------

## Random pretentious job titles

The function `random-pretentious-job-title` generates random pretentious job titles.

Here is a random pretentious job title:

```perl6
random-pretentious-job-title
```
```
# Forward Identity Synergist
```

The following command generates a list of six random pretentious job titles:

```raku
random-pretentious-job-title(6).raku
```
```
# ("Customer Quality Synergist", "Principal Impact Designer", "District Team Manager", "Internal Communications Executive", "Corporate Research Specialist", "Corporate Program Associate")
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
# +--------------------------------------+------------------------+-----------------------+
# |                  0                   |           1            |           2           |
# +--------------------------------------+------------------------+-----------------------+
# |               Стратег                |        Директор        |  Configuration Agent  |
# |         Human Quality Agent          |   Assurance Director   |       Supervisor      |
# | Internal Infrastructure Orchestrator | Специалист по Отговори | Дизайнер по Парадигми |
# |    Директен Асистент по Отговори     | Lead Paradigm Analyst  |     Администратор     |
# +--------------------------------------+------------------------+-----------------------+
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

```raku
say random-real(); 
```
```
# 0.781896535292538
```

Here is a random real between 0 and 20:

```raku
say random-real(20); 
```
```
# 13.072422505045779
```

Here are six random reals between -2 and 12:

```raku
say random-real([-2,12], 6);
```
```
# (11.864258861917264 4.890701998281822 7.1509704636994975 2.856699299326742 -1.2772229946471956 11.4367816302763)
```

Here is a 4-by-3 array of random reals between -3 and 3:

```raku
say random-real([-3,3], [4,3]);
```
```
# [[2.3294489626915276 -1.0950408598600314 -2.2898051328754807]
#  [-1.9248193884428577 0.7775337323750455 0.5662577115435008]
#  [2.793892442816027 -2.8554755650301713 2.3260442949686357]
#  [-2.8095178343640743 -2.4967975502939384 -1.0154613861655881]]
```


**Remark:** The signature design follows Mathematica's function
[`RandomReal`](https://reference.wolfram.com/language/ref/RandomVariate.html).


------

## Random variates

This module provides the function `random-variate` that can be used to generate lists of real numbers
using distribution specifications.

Here are examples:

```raku
say random-variate(NormalDistribution.new(:mean(10), :sd(20)), 5); 
```
```
# (-27.659188870179968 4.048485095109329 4.44985806317876 -4.534662024009972 1.7386988216711394)
```

```raku
say random-variate(NormalDistribution.new( µ => 10, σ => 20), 5); 
```
```
# (1.900787217179996 14.630607569797847 -7.012234809766465 6.296428231434105 5.123221681439648)
```

```raku
say random-variate(UniformDistribution.new(:min(2), :max(60)), 5);
```
```
# (8.71131881757636 42.992275827793456 36.47696163225245 46.38138517633746 7.321302330277626)
```

**Remark:** Only Normal distribution and Uniform distribution are implemented at this point.

**Remark:** The signature design follows Mathematica's function
[`RandomVariate`](https://reference.wolfram.com/language/ref/RandomVariate.html).

Here is an example of 2D array generation:

```raku
say random-variate(NormalDistribution.new, [3,4]);
```
```
# [[-0.5103182521990548 -0.5829429151529076 -0.5940839041945513 -1.0927896811728377]
#  [-0.43767702086129184 2.0452658692233983 -0.8459908693989825 1.1106283004104134]
#  [0.8070535406316326 -0.5660945212157695 0.6845858560140593 0.12401565911386467]]
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

```raku
my @dfRand = random-tabular-dataset(5, 3, column-names-generator => { random-pet-name($_, species => 'Cat') });
say to-pretty-table(@dfRand);
```
```
# +----------+-----------+-----------+
# | Canella  |    Opie   | Sunnyside |
# +----------+-----------+-----------+
# | eolithic | 21.871253 | 12.476871 |
# | shipside |  6.670374 | 16.933138 |
# |  holly   |  7.161387 |  7.932595 |
# | Romance  |  7.684871 | -8.726944 |
# |   silo   |  6.362423 | 23.188637 |
# +----------+-----------+-----------+
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

6. [ ] TODO Selection between `roll` and `pick` for:
    - [ ] TODO `RandomWord`  
    - [ ] TODO `RandomPetName`

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
