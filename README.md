# Raku Data::Generators

[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

This Raku package has functions for generating random strings, words, pet names, vectors, and
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

Here we generate a vector of random strings with length 4 and characters that belong to specified ranges:

```raku
use Data::Generators;
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```
```
# ("2y71", "0382", "nn74", "8606", "y835", "9ynN")
```

------

## Random words

The function `random-word` generates random words.

Here we generate a list with 12 random words:

```raku
random-word(12)
```
```
# (Gris blockading eligible superinfect Alopius blaster scutcheon betide weatherstrip calyx cagoule tonsorial)
```

Here we generate a table of random words of different types:

```raku
use Data::Reshapers;
my @dfWords = do for <Any Common Known Stop> -> $wt { $wt => random-word(6, type => $wt) };
say to-pretty-table(@dfWords);
```
```
# +--------+------------+-------------+--------------+----------+------------+------------+
# |        |     4      |      5      |      3       |    1     |     0      |     2      |
# +--------+------------+-------------+--------------+----------+------------+------------+
# | Any    |  kilowatt  | suggestible |     bob      |  alias   | canecutter |   relief   |
# | Common |  repeater  |     fray    | prizewinning | syllabus |  twister   | infinitely |
# | Known  | lovastatin |  epidermal  |  bombsight   | mesmeric |  bloodily  |   purau    |
# | Stop   |   there    |    don't    |      at      |  what's  |     W      |  they've   |
# +--------+------------+-------------+--------------+----------+------------+------------+
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
# ("Mae", "Tre", "Arya", "Darlene", "Nani", "Darlene")
```

The named argument `species` can be used to specify specie of the random pet names. 
(According to the specie-name relationships in [DG1].)

Here we generate a table of random pet names of different species:

```raku
my @dfPetNames = do for <Any Cat Dog Goat Pig> -> $wt { $wt => random-pet-name(6, species => $wt) };
say to-pretty-table(@dfPetNames);
```
```
# +------+----------+----------+-----------+---------+----------+---------+
# |      |    3     |    4     |     1     |    2    |    0     |    5    |
# +------+----------+----------+-----------+---------+----------+---------+
# | Any  | Guinness | Guinness |  Guinness |  Millie |   Nick   |  Bixby  |
# | Cat  |  Piton   |  Wilco   | Sassafras |  Sherpa |  Millie  |  Sagwa  |
# | Dog  |  Gumby   | Janosch  |   Conway  | Barclay | Barnabas | Desmond |
# | Goat | Abelard  | Winnipeg |   Aggie   |  Darcy  |  Mollie  |  Trixie |
# | Pig  | Atticus  |  Millie  |  Guinness |  Millie |  Millie  | Atticus |
# +------+----------+----------+-----------+---------+----------+---------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

The named argument (adverb) `weighted` can be used to specify random pet name choice 
based on known real-life number of occurrences:

```raku
srand(32);
say ‌‌random-pet-name(6, :weighted).raku
```
```
# ("Yoda", "Atticus", "Derry", "Brianna", "Lady Jane", "Jonesy")
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
# ("Global Intranet Liason", "Corporate Integration Coordinator", "Chief Identity Producer", "Investor Research Executive", "Human Branding Specialist", "District Accountability Analyst")
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
# +-------------------------------------+-------------------------+-------------------------+
# |                  0                  |            1            |            2            |
# +-------------------------------------+-------------------------+-------------------------+
# |       National Security Agent       |        Associate        |  Applications Executive |
# |            Administrator            |         Асистент        |     Security Liason     |
# |            Administrator            | Бъдещ Началник на Екипи |        Сътрудник        |
# | Interactive Directives Orchestrator |      Representative     | Dynamic Response Liason |
# +-------------------------------------+-------------------------+-------------------------+
```

**Remark:** `Whatever` can be used as values for the named arguments `number-of-words` and `language`.

**Remark:** The implementation uses the job title phrases in https://www.bullshitjob.com . 
It is, more-or-less, based on the Mathematica implementation 
[`RandomPretentiousJobTitle`](https://resources.wolframcloud.com/FunctionRepository/resources/RandomPretentiousJobTitle),
[AAf2].

------

## Random reals

This module provides the function `random-variate` that can be used to generate lists of real numbers
using distribution specifications.

Here are examples:

```raku
say random-variate(NormalDistribution.new(:mean(10), :sd(20)), 5); 
```
```
# (0.3188152214118932 0.6374758467119142 -0.9845376471401256 -0.051616165032416055 0.38843941490054695)
```

```raku
say random-variate(NormalDistribution.new( µ => 10, σ => 20), 5); 
```
```
# (0.08557423351930679 0.4357980962382811 1.5632657899320312 0.5377370434972556 1.336693538165896)
```

```raku
say random-variate(UniformDistribution.new(:min(2), :max(60)), 5);
```
```
# (33.34304556579362 49.752070912265765 26.324712608858476 27.36037856983648 15.786863918283364)
```

**Remark:** Only Normal distribution and Uniform distribution are implemented at this point.

**Remark:** The signature design follows Mathematica's function 
[`RandomVariate`](https://reference.wolfram.com/language/ref/RandomVariate.html).

Here is an example of 2D array generation:

```raku
say random-variate(NormalDistribution.new, [3,4]);
```
```
# [[1.1462731103950228 -0.012552195848549946 1.753488318598793 0.1111933863750451]
#  [0.5876960648111039 -1.3921304876748652 -0.4113963237852634 1.064268169499379]
#  [0.08421481417247456 0.3743110869167233 -0.9170427476442052 -0.725644239183156]]
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
# +----------------------+----------------------+--------------+
# |        Bumpas        |     Peggy Olson      | Wilde Thing  |
# +----------------------+----------------------+--------------+
# |  0.7995508135490423  |  0.9956028260128671  |   accursed   |
# | -0.5089750133767257  | -0.37570446722763806 | cosmopolite  |
# | 0.03424168415046484  | -0.04913796103775116 | transaminase |
# | -0.3540102751917398  | -0.5541490643317443  |  maturement  |
# | -0.25462837073369887 |  2.2384589378099804  |  deep-laid   |
# +----------------------+----------------------+--------------+
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

[WRI2] Wolfram Research (2014),
[Dataset](https://reference.wolfram.com/language/ref/Dataset.html),
Wolfram Language function.

### Data repositories

[DG1] Data.Gov,
[Seattle Pet Licenses](https://catalog.data.gov/dataset/seattle-pet-licenses),
[catalog.data.gov](https://catalog.data.gov).
