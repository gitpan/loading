#!perl

use Test::More tests => 3;

BEGIN {
    package A;
    no loading;
    use Exporter qw(import);
    our @EXPORT = qw(from_A);
    sub from_A { 'From ' . __PACKAGE__ }
}

BEGIN {
    package B;
    use Exporter qw(import);
    our @EXPORT = qw(from_B);
    sub from_B { 'From ' . __PACKAGE__ }
}

BEGIN {
    package C;
    use Exporter qw(import);
    our @EXPORT = qw(from_C);
    sub from_C { 'From ' . __PACKAGE__ }
}

no loading qw(B C);

use A;
is from_A(), 'From A', 'inplace';

use B;
is from_B(), 'From B', 'outside (B)';

use C;
is from_C(), 'From C', 'outside (C)';

