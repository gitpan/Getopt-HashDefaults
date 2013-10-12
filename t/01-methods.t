use Test::More;

use_ok 'Getopt::HashDefaults';

my $options = {
    'length=i' => '123.45',
    'help|?' => 0,
};
my $o = Getopt::HashDefaults->new;
$options = $o->getoptions($options);

is $options->{help}, 0, 'help';
is $options->{length}, '123.45', 'length';

done_testing();

# TODO Test the ->new('debug') output but SKIP unless Capture::Tiny
