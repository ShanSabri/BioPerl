#! /opt/perl/bin/perl

use strict;
use warnings;

my %hashOfArrays = (
	'HashKey1' =>  [
			 '1',
			 '2',
			 '3',
			 '4',		
			],

	'HashKey2' => [
			 '1',
			 '2',
			 '3',
			],
);

foreach my $key ( keys %hashOfArrays )  {
	print "Values in $key are: \n";
	foreach ( @{$hashOfArrays{$key}} )  {
		print "\t $_ \n";
	}
}

