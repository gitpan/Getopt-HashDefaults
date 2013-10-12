#!/usr/bin/perl
use strict;
use warnings;
#
# A simple example of Getopt::HashDefaults. - gene@cpan.org
#
# Try these:
# $ perl eg/simple.pl
# $ perl eg/simple.pl --help
#

use Getopt::HashDefaults;

# Set our argument labels, specifications and default values.
my $options = { 'help|?' => 0, 'length=i' => 123.45 };

# Set the optional configuration (documented in Go::L).
my @config = ();#qw( debug );

# Instantiate a new Getop holder!
my $o = Getopt::HashDefaults->new(@config);

# Get arguments from the command-line based on defined option entries.
$options = $o->getoptions($options);

# Show the value of our known entries.
printf "Help: %d, Length: %f\n", $options->{help}, $options->{length};

