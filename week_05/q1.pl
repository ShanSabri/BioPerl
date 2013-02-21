#! /usr/bin/perl

use strict;
use warnings;

my @array1=([1, 2, 3]);
my @array2=([2, 4, 6]);

multiplyArray(@array1, @array2);

sub multiplyArray{
	our @a = shift;
	our @b = shift;
	
	my $p = [];
	my $rows = @a;
	my $cols = @{$b[0]};
	my $n = @b - 1;
	
	for (my $i = 0 ; $i < $rows ; ++$i){
		for (my $j = 0 ; $j < $cols ; ++$j){
			$$p[$i][$j] += $a[$i][$_] * $b[$_][$j] foreach 0 .. $n;
			#$$p[$i][$j] += $a[$_][$j] * $b[$i][$_] foreach 0 .. $n;
		}
	}
	print "Reference to array product: $p \n";
	print "Dereferenced array product: \n";
	print "@$_\n" foreach @{$p};		
}

# expected output:
#  2  4  6
#  4  8  12
#  6  12 18

