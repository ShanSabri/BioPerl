#!/opt/perl/bin/perl

use strict;
use warnings;

my %hash = (
		key1 => 'value1',
		key2 => 'value2',
		key3 => 'value3',
		key4 => 'value4'
    );

sub hash_return {
	my $hash = @_;
	$hash{key5} = 'value5';
	return \%hash;
}

my $ref_to_sub = \&hash_return;
my $deref = $ref_to_sub -> (\%hash);
my %deref = %{$deref};

while ((my ($key, $value)) = each(%hash)){
     print "Key: $key\t Value: $value\n";
}
