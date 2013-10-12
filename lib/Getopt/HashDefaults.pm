package Getopt::HashDefaults;
BEGIN {
  $Getopt::HashDefaults::AUTHORITY = 'cpan:GENE';
}

# ABSTRACT: Allow hash default settings

our $VERSION = '0.01';
use strict;
use warnings;

use Getopt::Long;


sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}


sub getoptions {
    my $self = shift;
    # G::L default options.
    my $options = shift;

    # Collect the G::L argument specs.
    my @specs = keys %$options;

    # Recreate the options hash with "simpler" keys.
    $options = _simple_keys($options);

    # Call the OO parent function.
    my $o = Getopt::Long::Parser->new;
    $o->getoptions($options, @specs);

    # Return the simplified options.
    return $options;
}

# Build a "simpler" set of key-names for Getop::Long.
sub _simple_keys {
    # Get the G::L spec=>default config.
    my $hash = shift;

    # Declare a new label=>default config.
    my $simple;

    # Extract the new labels from the spec key strings.
    for my $key (keys %$hash) {
        # Is the key a G::L spec?
        if ($key =~ m/^(\w+)\W/) {
            # Extract the label for the new key.
            $simple->{$1} = $hash->{$key};
        }
        else {
            # The key is not a spec; just a label.
            $simple->{$key} = $hash->{$key};
        }
    }

    # Hand back the simplified config.
    return $simple;
}

1;

__END__

=pod

=head1 NAME

Getopt::HashDefaults - Allow hash default settings

=head1 VERSION

version 0.01

=head1 SYNOPSIS

  use Getopt::HashDefaults;
  my $config = {debug => 1};
  my $options = {
    'length=i' => 123.45,
    'help|?' => 0,
  };
  my $o = Getopt::HashDefaults->new($config);
  $options = $o->getoptions($options);
  print "Length: $options->{length}\n";

=head1 DESCRIPTION

C<Getopt::HashDefaults> uses L<Getopt::Long> to allow default settings without
scalar references.

Use this module instead of L<Getopt::Long> and call L</getoptions()> with a
reference to your default settings hash.

=head1 NAME

Getopt::HashDefaults - Allow hash default settings

=head1 METHODS

=head2 new()

 $o = Getopt::HashDefaults->new;

Create a new C<Getopt::Long::HashDefaults> instance.

=head2 getoptions()

Accept a hashref of L<Getopt::Long> arguments, extract the argument specs and
call the object oriented version of L<Getopt::Long/getoptions>.

=head1 SEE ALSO

L<Getopt::Long>

=head1 AUTHOR

Gene Boggs <gene@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Gene Boggs.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
