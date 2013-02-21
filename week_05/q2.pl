#! /opt/perl/bin/perl
  
use strict;
use warnings;
use Storable;
  
my @bases = qw/ A C G T /;
  
sub random_sequence {
	#for (my $i=0; $i<10; $i++){  
		foreach (1..50) {print $bases[int(rand(4))];}
		print "\n";
  }
}

#random_sequence();

my @nuc = ( 'A' , 'T' , 'C' , 'G' );
        my $DNA;
        $DNA .= $nuc[rand @nuc] for 1..$length;
        print "Random DNA Sequence: \n $DNA \n";


my @dnaSequences = (
	{ 'DNA1' = random_sequence() },
	{ 'DNA2' = random_sequence() }
);


