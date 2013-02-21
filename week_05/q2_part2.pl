#! /opt/perl/bin/perl

use strict;
use warnings;
use Storable;

my $dataref = retrieve( 'file' );

use Data::Dumper;
print Dumper $dataref;

while( my ($key, $value) = each %{$dataref}){
	foreach my $base (qw/A C G T/){
		my @count = ($value =~ /$base{4}/);
		if(@count){
			print "Run ", $base x 4, " found ",
			 scalar @count, " times in $key\n";
		}
	}
}
