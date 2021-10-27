unit module Data::Generators::RandomPretentiousJobTitle;

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

#============================================================
sub RandomPretentiousJobTitle(UInt $size = 1, :$number-of-words is copy = 3, :$language is copy = 'English') is export {

    if not ( $number-of-words ~~ Int and $number-of-words > 0 or $number-of-words.isa(Whatever) ) {
        note "The arugment 'number-of-words' is expected to be one of 1, 2, 3, or Whatever. Continue using 3.";
        $number-of-words = 3
    }

    if not ( $language.isa(Whatever) or ( $language ~~ Str ) and %pretentiousJobTitleWords{$language.lc}:exists) {
        note "The argument 'language' is expected to be one of { %pretentiousJobTitleWords.keys».tc.join(', ') } or Whatever. Continue with English.";
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
    @phrases
}