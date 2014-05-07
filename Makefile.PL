use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'loading',
    AUTHOR              => q{Anno Siegel <anno5@mac.com>},
    VERSION_FROM        => 'lib/loading.pm',
    ABSTRACT_FROM       => 'lib/loading.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'loading-*' },
);
