#! /usr/bin/perl

use strict;
use warnings;

my @array1=([1, 2, 3]);
my @array2=([2, 4, 6]);

multiplyArray(@array1, @array2);

sub multiplyArray{
	my ($array1, $array2) = @_;
	my @result;

	foreach my $array1_i (@$array1){
		my @row;
		foreach my $array2_j (@$array2){
			push @row, $array1_i * $array2_j;
		}
		push @result, \@row;
    	}
	print "Reference to array product: ", \@result, "\n";
	print "Dereferenced array product: \n";
	print "@$_\n" foreach @result;
}
