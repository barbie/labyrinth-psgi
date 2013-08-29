package Labyrinth::PSGI;

use warnings;
use strict;

our $VERSION = '1.00';

use Labyrinth;
use Labyrinth::Variables;

sub new {
    my ($class,$env,$cnf) = @_;

    my $lab = Labyrinth->new();

    # create an attributes hash
    my $atts = {
        cnf => $cnf,
        lab => $lab
    };

    # create the object
    bless $atts, $class;

    $settings{psgi}{env} = $env;

    return $atts;
};

sub run {
    my $self = shift;
    my $cnf  = shift || $self->{cnf};

    return [ 500, 'text/html', [ '<html><head><title>Oops!</title></head><body>Oops, something went wrong</body></html>' ] ]
        unless($cnf && -f $cnf);

    $self->{lab}->run( $cnf );

    return [ $settings{psgi}{status}, $settings{psgi}{headers}, [ $settings{psgi}{body} ] ];
}

1;

__END__

=head1 NAME

Labyrinth::PSGI - Digital Image Utilities for Labyrinth

=head1 SYNOPSIS

Update your settings file to include the following lines.

    query-parser=PSGI
    writer-render=PSGI

=head1 DESCRIPTION

Handles the driver software for image manipulation;

=head1 SEE ALSO

  CGI::PSGI
  Labyrinth

=head1 AUTHOR

Barbie, <barbie@missbarbell.co.uk> for
Miss Barbell Productions, L<http://www.missbarbell.co.uk/>

=head1 COPYRIGHT & LICENSE

  Copyright (C) 2013 Barbie for Miss Barbell Productions
  All Rights Reserved.

  This module is free software; you can redistribute it and/or
  modify it under the Artistic License 2.0.

=cut
