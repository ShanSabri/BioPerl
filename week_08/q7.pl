#! /opt/perl/bin/perl

use strict;
use warnings;

sub manipulate_table {
	my @table = @_;
	my $column = 0;
	my @pivot;
	$column < $#$_ and $column = $#$_ for @table;

	for my $c (0..$column) {
		my @row;
		for my $r (0..$#table) {
			push @row, $table[$r][$c] // '';
		}
		push @pivot, \@row;
	}
	return @pivot;
}

my @a1 = qw(one four seven);
my @a2 = qw(two five eight);
my @a3 = qw(three six nine);
my @big_array = ([@a1],[@a2],[@a3]);

my @newTable = manipulate_table(@big_array);

print "@$_\n" foreach @newTable;
