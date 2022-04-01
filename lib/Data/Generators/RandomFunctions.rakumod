use Data::Generators::ResourceAccess;
my Data::Generators::ResourceAccess $resources.instance;

unit module Data::Generators::RandomFunctions;

#============================================================
sub is-positional-of-strings($vec) {
    ($vec ~~ Positional) and ($vec.all ~~ Str)
}

sub reallyflat (+@list) {
    gather @list.deepmap: *.take
}

#============================================================
our proto RandomString(|) is export {*}

multi RandomString(UInt $size = 1,
                   :$chars is copy = Whatever,
                   :$ranges is copy = ("a" .. "z", "A" .. "Z", "0" .. "9")
        --> List) {

    if $size == 0 {
        die "The first argument is expected to be a positive integer."
    }

    if $chars.isa(Whatever) { $chars = [2 .. 20] }
    if $chars ~~ Numeric { $chars = ($chars.Int,) }
    if not ($chars.isa(Array) or $chars.isa(List)) {
        die "The argument 'chars' is expected to be a positive integer, a list of positive integers, or Whatever."
    }

    if $ranges.isa(Range) or is-positional-of-strings($ranges) { $ranges = [$ranges,] }
    if $ranges.isa(Whatever) { $ranges = ("a" .. "z", "A" .. "Z", "0" .. "9") }

    if not (($ranges.isa(Array) or $ranges.isa(List)) and
            ($ranges.all ~~ Range or $ranges.all ~~ (is-positional-of-strings($_)))) {
        die "The argument 'ranges' is expected to be a range, a list of ranges, or Whatever."
    }

    my $res = do for ^$size {
        reallyflat($ranges).roll($chars.pick).join;
    }

    $res.List
}

#============================================================
our proto RandomWord(|) is export {*}

multi RandomWord(UInt $size = 1,
                 :$type is copy = Whatever,
                 Str :$language is copy = 'English',
                 :&method is copy = &roll
        --> List) {

    if $size == 0 {
        die "The first argument is expected to be a positive integer."
    }

    if $type.isa(Whatever) { $type = 'any' }

    if not $type.isa(Str) and $type.lc (elem) <any common known stopword> {
        note "The argument 'type' is expected to be one of 'any', 'common', 'known', 'stopword', or Whatever. Continuing with 'any'.";
        $type = 'any'
    }

    if $language.isa(Whatever) { $language = 'English' }

    if not $language.isa(Str) and $language.lc eq 'english' {
        die "The argument 'language' is expected to be one of 'English' or Whatever. (Only English words are supported at this time.)"
    }

    if &method.isa(WhateverCode) || &method.isa(Whatever) { &method = &roll }

    if $type.lc eq 'any' {
        return $resources.get-random-word($size, :&method);
    } elsif $type.lc (elem) <known common> {
        return $resources.get-random-word($size, $type.lc, :&method);
    } elsif $type.lc (elem) <stop stopword> {
        return $resources.get-random-word($size, 'stopword', :&method);
    } else {
        # Should not happen
        die "Unknown type $type."
    }
}

#============================================================
our proto RandomPetName(|) is export {*}

multi RandomPetName(UInt $size = 1,
                    :$species is copy = Whatever,
                    Bool :$weighted = True,
                    :&method is copy = &roll
        --> List) {

    if $size == 0 {
        die "The first argument is expected to be a positive integer."
    }

    my @allSpecies = <Any Cat Dog Goat Pig>;

    if not ( $species.isa(Whatever) or $species.isa(Str) and ($species.lc (elem) @allSpecies».lc) ) {
        note "The argument 'species' is expected to be one of { @allSpecies.raku }, or Whatever. Continuing with Whatever.";
        $species = Whatever
    }

    if &method.isa(WhateverCode) || &method.isa(Whatever) { &method = &roll }

    if $species.isa(Whatever) or $species.lc eq 'any'  {
        return $resources.get-random-pet-name($size, Whatever, :weighted, :&method);
    } else {
        return $resources.get-random-pet-name($size, $species, :$weighted, :&method);
    }
}

#============================================================
my %pretentiousJobTitleWords =
        %(
            'english' =>
                    %(
                        'uno' => ('Lead', 'Senior', 'Direct', 'Corporate', 'Dynamic',
                                  'Future', 'Product', 'National', 'Regional', 'District',
                                  'Central', 'Global', 'Relational', 'Customer', 'Investor',
                                  'Dynamic', 'International', 'Legacy', 'Forward', 'Interactive',
                                  'Internal', 'Human', 'Chief', 'Principal'),
                        'zwei' => ('Solutions', 'Program', 'Brand', 'Security', 'Research',
                                   'Marketing', 'Directives', 'Implementation', 'Integration',
                                   'Functionality', 'Response', 'Paradigm', 'Tactics', 'Identity',
                                   'Markets', 'Group', 'Resonance', 'Applications', 'Optimization',
                                   'Operations', 'Infrastructure', 'Intranet', 'Communications',
                                   'Web', 'Branding', 'Quality', 'Assurance', 'Impact', 'Mobility',
                                   'Ideation', 'Data', 'Creative', 'Configuration',
                                   'Accountability', 'Interactions', 'Factors', 'Usability',
                                   'Metrics', 'Team'),
                        'trois' => ('Supervisor', 'Associate', 'Executive', 'Liason',
                                    'Officer', 'Manager', 'Engineer', 'Specialist', 'Director',
                                    'Coordinator', 'Administrator', 'Architect', 'Analyst',
                                    'Designer', 'Planner', 'Synergist', 'Orchestrator', 'Technician',
                                    'Developer', 'Producer', 'Consultant', 'Assistant',
                                    'Facilitator', 'Agent', 'Representative', 'Strategist')
                    ),
            'bulgarian' =>
                    %(
                        'uno' => ('Бъдещ', 'Водещ', 'Главен', 'Старши', 'Човешки', 'Вътрешен',
                                  'Глобален', 'Директен', 'Клиентов', 'Областен', 'Динамичен',
                                  'Динамичен', 'Централен', 'Инвестиращ', 'Национален', 'Регионален',
                                  'Релационен', 'Наследствен', 'Прогресивен', 'Интерактивен',
                                  'Корпоративен', 'Международен', 'Продукционен'),
                        'zwei' => ('Идеи', 'Групи', 'Данни', 'Екипи', 'Марки', 'Мрежи',
                                   'Пазари', 'Отговори', 'Решения', 'Тактики', 'Фактори', 'Интранет',
                                   'Качество', 'Операции', 'Програми', 'Директиви', 'Маркетинг',
                                   'Мобилност', 'Отчетност', 'Парадигми', 'Прилагане', 'Резонанси',
                                   'Сигурност', 'Брандиране', 'Интеграция', 'Показатели', 'Приложения',
                                   'Въздействие', 'Идентичност', 'Изследвания', 'Комуникации',
                                   'Креативност', 'Оптимизация', 'Осигуряване', 'Конфигурации',
                                   'Използваемост', 'Взаимодействия', 'Функционалности',
                                   'Инфраструктурата'),
                        'trois' => ('Агент', 'Плановик', 'Техник', 'Инженер', 'Стратег',
                                    'Архитект', 'Асистент', 'Дизайнер', 'Директор', 'Мениджър',
                                    'Началник', 'Служител', 'Посредник', 'Продуцент', 'Синергист',
                                    'Сътрудник', 'Анализатор', 'Изпълнител', 'Консултант', 'Специалист',
                                    'Координатор', 'Оркестратор', 'Разработчик', 'Супервайзор',
                                    'Фасилитатор', 'Представител', 'Проектант', 'Администратор'),
                        'conjunction' => ('на', 'по')
                    )
        );

#------------------------------------------------------------
our sub RandomPretentiousJobTitle(UInt $size = 1, :$number-of-words is copy = 3, :$language is copy = 'English')
        is export {

    if not ($number-of-words ~~ Int and $number-of-words > 0 or $number-of-words.isa(Whatever)) {
        note "The argument 'number-of-words' is expected to be one of 1, 2, 3, or Whatever. Continue using 3.";
        $number-of-words = 3
    }

    if not ($language.isa(Whatever) or ($language ~~ Str) and %pretentiousJobTitleWords{$language.lc}:exists) {
        note "The argument 'language' is expected to be one of { %pretentiousJobTitleWords.keys».tc.join(', ') } or Whatever. Continuing with 'English'.";
        $language = 'English'
    }

    ## Generation
    my @phrases =
            do for ^$size -> $i {

                my $loopLang = $language;
                if $loopLang.isa(Whatever) {
                    $loopLang = %pretentiousJobTitleWords.keys.pick()
                }

                my %jobTitleWords = %pretentiousJobTitleWords{$loopLang.lc};

                my $n = $number-of-words;
                if $n.isa(Whatever) { $n = [1, 2, 3].pick() }

                my @res = [
                    |%jobTitleWords<uno>.pick(1),
                    |%jobTitleWords<zwei>.pick(1),
                    |%jobTitleWords<trois>.pick(1)
                ];

                @res = @res[(3 - $n) .. 2];

                if $loopLang.lc eq "Bulgarian".lc and @res.elems > 1 {

                    my $conj = %pretentiousJobTitleWords{$loopLang.lc}{'conjunction'}.pick();

                    if @res.elems == 2 {
                        @res = (@res[1], $conj, @res[0])
                    } elsif @res.elems == 3 {
                        @res = (@res[0], @res[2], $conj, @res[1])
                    }
                }

                @res.join(' ')
            }

    ## Result
    @phrases.List
}
