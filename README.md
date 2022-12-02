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
# Yb7AIaqxM
```

Here we generate a vector of random strings with length 4 and characters that belong to specified ranges:

```perl6
say random-string(6, chars => 4, ranges => [ <y n Y N>, "0".."9" ] ).raku;
```
```
# ("nnNy", "Y304", "81Y5", "799n", "y92y", "2292")
```

------

## Random words

The function `random-word` generates random words.

Here is a random word:

```perl6
random-word
```
```
# hosiery
```

Here we generate a list with 12 random words:

```perl6
random-word(12)
```
```
# (Paul vandal ergotropism unbeholden silviculture three-fold sporophyl nonadaptive untying photometrically hourglass-shaped informality)
```

Here we generate a table of random words of different types:

```perl6
use Data::Reshapers;
my @dfWords = do for <Any Common Known Stop> -> $wt { $wt => random-word(6, type => $wt) };
say to-pretty-table(@dfWords);
```
```
# +--------+---------------+-------------+-----------+---------------+---------------+-------------+
# |        |       1       |      5      |     2     |       3       |       4       |      0      |
# +--------+---------------+-------------+-----------+---------------+---------------+-------------+
# | Any    | cannibalistic |  jacklight  |  sit-down |   Sarcophaga  |   foreshore   | unprovoking |
# | Common | ventriloquism |   deathly   |  pinched  |      hazy     |  exhilaration |   seizure   |
# | Known  |   Charleroi   | educational | reassured | pervasiveness | osteomyelitis | popularizer |
# | Stop   |       up      |    three    |    we'd   |    someone    |       N       |    become   |
# +--------+---------------+-------------+-----------+---------------+---------------+-------------+
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
# Bengal Billy
```

The following command generates a list of six random pet names:

```perl6
srand(32);
random-pet-name(6).raku
```
```
# ("Annie", "Pippa", "Bastet", "Amos", "Dobby", "Otis")
```

The named argument `species` can be used to specify specie of the random pet names. 
(According to the specie-name relationships in [DG1].)

Here we generate a table of random pet names of different species:

```perl6
my @dfPetNames = do for <Any Cat Dog Goat Pig> -> $wt { $wt => random-pet-name(6, species => $wt) };
say to-pretty-table(@dfPetNames);
```
```
# +------+----------+----------+----------+----------+--------+-----------+
# |      |    1     |    5     |    3     |    0     |   4    |     2     |
# +------+----------+----------+----------+----------+--------+-----------+
# | Any  |  Astro   |  Wilder  | Jezebell |   Kiki   | Lillie |   Junior  |
# | Cat  |   Poet   |   Mimi   |  Dinah   |  Buddy   | Tsuki  | Mish Mish |
# | Dog  |  Tilly   | Gremlin  |   Hank   |  Rusty   | Lattie |   Oscar   |
# | Goat | Phyllis  |   Arya   | Grayson  | Winnipeg | Olive  |   Pepina  |
# | Pig  | Guinness | Guinness | Atticus  | Atticus  | Millie |   Millie  |
# +------+----------+----------+----------+----------+--------+-----------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

The named argument (adverb) `weighted` can be used to specify random pet name choice 
based on known real-life number of occurrences:

```perl6
srand(32);
say random-pet-name(6, :weighted).raku
```
```
# ("Randall", "Holly", "Darwin", "Dobby", "Grace", "Randall")
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
# Human Infrastructure Representative
```

The following command generates a list of six random pretentious job titles:

```perl6
random-pretentious-job-title(6).raku
```
```
# ("Human Quality Agent", "Principal Optimization Analyst", "Corporate Tactics Orchestrator", "Regional Functionality Liason", "Senior Identity Strategist", "Dynamic Assurance Assistant")
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
# +---------------------------------+-------------------------+------------------------+
# |                0                |            1            |           2            |
# +---------------------------------+-------------------------+------------------------+
# |             Producer            | Lead Intranet Executive |      Координатор       |
# |      Functionality Engineer     |  Проектант на Сигурност | Консултант на Фактори  |
# |       Team Representative       |        Developer        |   Ideation Associate   |
# | Международен Синергист на Екипи |         Директор        | Специалист по Интранет |
# +---------------------------------+-------------------------+------------------------+
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
# 0.823311567452858
```

Here is a random real between 0 and 20:

```perl6
say random-real(20); 
```
```
# 8.49801870321288
```

Here are six random reals between -2 and 12:

```perl6
say random-real([-2,12], 6);
```
```
# (10.525298125517176 -0.160159274007879 2.672814688202422 5.527668440349444 4.3512488041464525 4.305349381763433)
```

Here is a 4-by-3 array of random reals between -3 and 3:

```perl6
say random-real([-3,3], [4,3]);
```
```
# [[-1.7993126138777786 0.551660370629194 -0.5016917629847013]
#  [-0.06086236254033972 0.1693377003888683 -2.5669006814424993]
#  [-1.1093996028708428 -2.194031366393758 1.4803083229587681]
#  [-0.020162563090070584 1.3918098727256725 -2.346036020994049]]
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
# (16.81658436103202 5.817180544875238 -40.8144632769038 -13.680598925164187 2.3382868588201617)
```

```perl6
say random-variate(NormalDistribution.new( µ => 10, σ => 20), 5); 
```
```
# (16.86266456205295 12.016016900230937 17.41122530373141 1.740154482109375 -0.14707388517859066)
```

```perl6
say random-variate(UniformDistribution.new(:min(2), :max(60)), 5);
```
```
# (36.144915868256405 22.28269373774428 14.309270075186895 19.765186450466164 20.918533285852693)
```

**Remark:** Only Normal distribution and Uniform distribution are implemented at this point.

**Remark:** The signature design follows Mathematica's function
[`RandomVariate`](https://reference.wolfram.com/language/ref/RandomVariate.html).

Here is an example of 2D array generation:

```perl6
say random-variate(NormalDistribution.new, [3,4]);
```
```
# [[0.47118518345990706 -0.77214220582723 -1.5856914640909907 0.479642411665097]
#  [0.2233627474776211 -0.8156297626961373 3.03387546449567 -0.9457975686791236]
#  [-0.7116595366808489 0.8286687955423618 0.5090917888621337 1.9829419352124724]]
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
# +-----------+-----------------+------------------+
# |    Lars   |     Chester     |      Leeloo      |
# +-----------+-----------------+------------------+
# | 18.679104 |     H3obRqu0    |    qUZ0v3biEZ    |
# | 13.072346 | phy3foFyXHLSv3g |     3d6HEk8      |
# |  1.246342 | UdM4YfN4G5ZYP0r | 3z7mI1EsfS1gagCw |
# | 10.252623 |       UqR       |        Bc        |
# | 11.023103 |     fxVH24KW    |     qnQHIFS      |
# +-----------+-----------------+------------------+
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
