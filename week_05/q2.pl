#! /opt/perl/bin/perl
  
use strict;
use warnings;
use Storable;
 
sub random_sequence {	
	my @nuc = ( 'A' , 'T' , 'C' , 'G' );
        my $DNA;
        $DNA .= $nuc[rand @nuc] for 1..50;
	return $DNA;
}

my %DNAsequences;
for my $i (1..10){
    $DNAsequences{'DNA'.$i} = random_sequence();
}
 
store \%DNAsequences, 'file';
