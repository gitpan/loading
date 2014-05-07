package loading;

use 5.006;
use strict;
use warnings;

=head1 NAME

loading - Pragma to exempt a module from loading

=head1 VERSION

Version 1.02

=cut

our $VERSION = '1.02';

sub unimport {
    my ($client, @modules) = @_;
    my ($caller, $file) = caller;
    unshift @modules, $caller unless @modules;
    for ( @modules ) {
        s{::} {/}g;
        $_ .= '.pm';
        next if exists $INC{$_};
        $INC{$_} = $file;
    }
}

__PACKAGE__
__END__

=head1 SYNOPSIS

In some file (probably a script)

    BEGIN {
        package Some::Module;
        no loading; # exempt the current package (Some::Module) from loading
        use Exporter qw(import);
        our @EXPORT = qw(lala);

        sub lala { print "lala\n" }
    }

    use Some::Module; # would die without "no loading" above

    lala; # prints "lala", imported from Some::Module

Alternatively you can specify the package(s) to exempt from loading
in the C<no> statement

    BEGIN {
        package Some::Module;
        use Exporter qw(import);
        our @EXPORT = qw(lala);

        sub lala { print "lala\n" }
    }
    no loading qw(Some::Module); # exempt Some::Module from loading

    use Some::Module;
    lala;

=head1 Description

C<no loading> dispenses the current package from being loaded
from a .pm file when C<use>d later in the same file.

C<no loading qw(Some::Module Other::Module)> dispenses the named
moduled from being loaded.

If a module has already been loaded from somewhere C<no loading>
is a no-op, so it does no harm. C<use loading ...;> has no effect,
it doesn't countermand C<no loading ...;>.

In effect, C<no loading> saves you the

    BEGIN { Some::Module->import(<args>) }

you'd have to write in place of a use-statement in the same file
where Some::Module is defined. That's a convenience, but it makes
the file more readable. If the purpose of the file is to demonstrate
various use-statements, the difference may be significant.

=head1 SEE ALSO

C<me::inline> by ETHER covers pretty much the same territorry.
Thanks to DOLMEN for alerting me to the fact.

=head1 AUTHOR

Anno Siegel, C<< <anno5 at mac.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-loading at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=loading>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc loading


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=loading>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/loading>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/loading>

=item * Search CPAN

L<http://search.cpan.org/dist/loading/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2014 Anno Siegel.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of loading
