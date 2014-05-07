#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'loading' ) || print "Bail out!\n";
}

diag( "Testing loading $loading::VERSION, Perl $], $^X" );
