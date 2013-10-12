package Getopt::HashDefaults;
BEGIN {
  $Getopt::HashDefaults::AUTHORITY = 'cpan:GENE';
}

# ABSTRACT: Single declaration default settings

our $VERSION = '0.0201';
use strict;
use warnings;

use Getopt::Long;


sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->_init(@_);
    return $self;
}

sub _init {
    my ($self, @config) = @_;
    $self->{parser} = Getopt::Long::Parser->new;
    # Add Go::L configuration if any are passed in.
    $self->{parser}->configure(@config) if @config;
}


sub getoptions {
    my $self = shift;
    # G::L default options.
    my $options = shift;

    # Collect the G::L argument specs.
    my @specs = keys %$options;

    # Recreate the options hash with "simpler" keys.
    $options = _simple_keys($options);

    # Call the OO "parent" function.
    $self->{parser}->getoptions($options, @specs);

    # Return the simplified options.
    return $options;
}

# Build a "simpler" set of key-names for Go::L.
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

Getopt::HashDefaults - Single declaration default settings

=head1 VERSION

version 0.0201

=head1 SYNOPSIS

  use Getopt::HashDefaults;
  my $options = { 'length=i' => 123.45, 'help|?' => 0 };
  my @config = qw(debug);
  my $o = Getopt::HashDefaults->new(@config);
  $options = $o->getoptions($options);
  print "Length: $options->{length}\n";

=head1 DESCRIPTION

C<Getopt::HashDefaults> allows you to use a single hash of default values to
define L<Getop::Long> specs, labels and values, in a single, flat hash.

So, instead of these 8 statements and 7 variables:

  my $verbose = 0;
  my $debug   = 0;
  my $filter  = 1;
  my $length  = 3.1415;
  my $size    = 1_000_000;
  my $colours = [qw(a b c)];
  my %h = ();
  GetOptions(\%h, 'verbose', 'debug', 'filter', 'length=i', 'size=i', 'colours=s@');

C<Getopt::HashDefaults> lets you declare a spec, label and default value once.
It lets you hold these default values in a hash explicitly, instead of separate
scalars and references.  (Also: only 3 statements, 2 variables and less chars)

  my $h = {
    'verbose'    => 0,
    'debug'      => 0,
    'filter'     => 1,
    'length=i'   => 3.1415,
    'size=i'     => 1_000_000,
    'colours=s@' => [qw(a b c)],
  };
  my $o = Getopt::HashDefaults->new;
  $h = $o->getoptions($h);

=head1 NAME

Getopt::HashDefaults - Single declaration default settings

=head1 METHODS

=head2 new()

 $o = Getopt::HashDefaults->new;

Create a new C<Getopt::HashDefaults> instance.

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
