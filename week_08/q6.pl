#!/opt/perl/bin/perl

use strict;
use warnings;

sub min_num {   
	my @numbers = @_;
	my $min = @numbers[0, 0];

	foreach my $n (@numbers) {
		$min = $n if ($n < $min);
	}
	return $min;
}

sub max_num {
	my @numbers = @_;
	my $max = @numbers[0, 0];

	foreach my $n (@numbers) {
		$max = $n if ($n > $max);
	}
	return $max;
}

my @list = (1, 2, 3, 4, 5);

my $min_val = min_num(@list);
my $max_val = max_num(@list);

print "Return value for min_num() = $min_val\n";
print "Return value for max_num() = $max_val\n";

