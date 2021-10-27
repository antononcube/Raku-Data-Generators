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
# ("1101", "N104", "Y400", "4744", "9NYN", "979y")
```

------

## Random word

The function `random-word` generates random words.

Here we generate a list with 12 random words:

```raku
random-word(12)
```
```
# (Chou bullfinch sideroblast fixer-upper residence dare fogbank alphabetisation humanness trapshooting kimono morbid)
```

Here we generate a table of random words of different types:

```raku
use Data::Reshapers;
my @dfWords = do for <Any Common Known Stop> -> $wt { $wt => random-word(6, type => $wt) };
say to-pretty-table(@dfWords);
```
```
# +--------+-----------+--------------+-----------+---------------+------------+------------+
# |        |     1     |      3       |     4     |       0       |     2      |     5      |
# +--------+-----------+--------------+-----------+---------------+------------+------------+
# | Any    |  dynamite | defenceless  |    SLE    |    Leibniz    |  know-all  | polemicist |
# | Common |  ballgame | comfortingly | swaggerer | disappointing |  bagging   |   lemma    |
# | Known  | ragpicker |    rather    |  commute  |     shamus    | Tolypeutes | expressly  |
# | Stop   |     go    |     most     |     M     |       1       |    same    |     v      |
# +--------+-----------+--------------+-----------+---------------+------------+------------+
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
# ("Millie", "Marly", "Mazie Blue", "Guinness", "Kassy", "Guinness")
```

The named argument `species` can be used to specify specie of the random pet names. 
(According to the specie-name relationships in [DG1].)

Here we generate a table of random pet names of different species:

```raku
my @dfPetNames = do for <Any Cat Dog Goat Pig> -> $wt { $wt => random-pet-name(6, species => $wt) };
say to-pretty-table(@dfPetNames);
```
```
# +------+----------+---------+-----------+---------+---------+-----------------+
# |      |    4     |    3    |     2     |    5    |    1    |        0        |
# +------+----------+---------+-----------+---------+---------+-----------------+
# | Any  |   Kiki   |   Kiki  |   Moppet  |  Kikki  |   Kiki  |       Moji      |
# | Cat  |  Marge   | Tribeca | Cornflake |  Althea | Onigiri |     Panthera    |
# | Dog  |  Geely   |  Pelusa |   Inyri   |   Pepo  | Martine |       Pym       |
# | Goat |  Molly   | Schmidt |   Linda   |  Sassy  |  Trixie | Brussels Sprout |
# | Pig  | Guinness |  Millie |   Millie  | Atticus | Atticus |     Guinness    |
# +------+----------+---------+-----------+---------+---------+-----------------+
```

**Remark:** `Whatever` can be used instead of `'Any'`.

The named argument (adverb) `weighted` can be used to specify random pet name choice 
based on known real-life number of occurrences:

```raku
srand(32);
say ‌‌random-pet-name(6, :weighted).raku
```
```
# ("Guinness", "Fiona", "Liza", "Guinness", "Nico", "Mingeow")
```

The weights used correspond to the counts from [DG1].

------

## Random pretentious job titles

The function `random-pretentious-job-title` generates random pretentious job titles.

The following command generates a list of six random pretentious job titles:

```raku
random-pretentious-job-title(6).raku
```
```
# ("Interactive Research Designer", "National Integration Architect", "Senior Intranet Strategist", "Product Brand Consultant", "Corporate Research Consultant", "National Team Analyst")
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
# +----------------------+------------------------------------+---------------------------------+
# |          0           |                 1                  |                2                |
# +----------------------+------------------------------------+---------------------------------+
# |       Designer       | Вътрешен Консултант на Комуникации |     Chief Mobility Engineer     |
# |      Executive       |             Консултант             |            Посредник            |
# | Operations Assistant |      Разработчик на Отчетност      |          Агент на Данни         |
# |   Web Orchestrator   |  Регионален Техник на Изследвания  | Глобален Сътрудник по Сигурност |
# +----------------------+------------------------------------+---------------------------------+
```

**Remark:** `Whatever` can be used as values for the named arguments `number-of-words` and `language`.

**Remark:** The implementation uses the job title phrases in https://www.bullshitjob.com . 

------

## TODO

1. [ ] Random tabular datasets generation

2. [ ] Random reals vectors generation

3. [ ] Random reals vectors generation according to distribution specs

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

[SHf1] Sander Huisman,
[RandomString](https://resources.wolframcloud.com/FunctionRepository/resources/RandomString),
(2021),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository).

### Data repositories

[DG1] Data.Gov,
[Seattle Pet Licenses](https://catalog.data.gov/dataset/seattle-pet-licenses),
[catalog.data.gov](https://catalog.data.gov).
