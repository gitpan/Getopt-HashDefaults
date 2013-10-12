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

# Set argument labels, specs and defaults.
my $options = { 'help|?' => 0, 'length=i' => 123.45 };

# Get a new command-line processor.
my $o = Getopt::HashDefaults->new;

# Get the command-line arguments given to this script.
$options = $o->getoptions($options);

# Show the values of the options entries.
print "Help: $options->{help}, Length: $options->{length}\n";

