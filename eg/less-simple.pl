#!/usr/bin/perl
use strict;
use warnings;
#
# An advanced example of Getopt::HashDefaults. - gene@ology.net
#
use Data::Dumper;
use Getopt::HashDefaults;
use Pod::Usage;

our $VERSION = '0.01';

# Set our argument labels, specifications and default values.
my $options = {
    'man'         => 0,
    'verbose!'    => 0,
    'debug+'      => 0,
    'numeric=i'   => 42,
    'float=f'     => 123.456,
    'string=s'    => 'Hello!',
    'multi=s{1,}' => [qw( foo bar )],
    'define=s%'   => { foo => 42, bar => -1 },
    'sub=i'       => sub { return 667 },
};

# Set the optional configuration (documented in Go::L).
my @config = qw( auto_version auto_help );

# Instantiate a new Go::HD object.
my $o = Getopt::HashDefaults->new(@config);

# Get arguments from the command-line based on defined option entries.
$options = $o->getoptions($options) || pod2usage(-verbose => 0);
pod2usage(-verbose => 1) if $options->{help};
pod2usage(-verbose => 2) if $options->{man};

printf "Verbose: %d, Debug: %d, Numeric: %d, Float: %.2f, String: %s\n",
    $options->{verbose}, $options->{debug},
    $options->{numeric}, $options->{float},
    $options->{string};
print "Multi: @{$options->{multi}}\n";
print 'Define: ', Dumper($options->{define}), "\n";
print "Sub: $options->{sub}\n";

__END__

=head1 NAME

less-simple.pl - Using Getopt::HashDefaults with advanced Go::L features

=head1 SYNOPSIS

less-simple.pl [options]

Options:

   --help     Brief help message
   --man      Full documentation
   --verbose  Or --noverbose
   --debug    Incremental
   --numeric  An integer value
   --float    A floating point number
   --string   An arbitrary string
   --multi    A list of strings
   --define   A key=>value store
   --sub      A user defined return
};

=head1 DESCRIPTION

An example of using the Getopt::HashDefaults module with advanced Getopt::Long
features and different argument types.

=cut
