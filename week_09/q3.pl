#!/opt/perl/bin/perl
use strict; 
use warnings;

use RestrictionEnzyme_Q3;

my $enzyme = RestrictionEnzyme_Q3->new(
			name => "EcoRI" , 
			manufacturer => "Promega" ,
			recognition_sequence => "G'AATTC"
			);

my $dna = 'AAAAAAAAGAATTCAAAAAAAAAGAATTCAAAAAAA';

my @results = $enzyme->cut_dna($dna); 
my $frag = 1;
if ($results[0] ne "Enzyme has no cut site!\n"){
	foreach (@results){
		print "Fragment #$frag: " . $_ . "\n";
		$frag++;
	}
}else{
	print "\nNo results found." . 
	  " Please verify that the enzyme has a cut pattern.\n";
}

##############################################
# Note that this script is the exact same as #
# q1.pl but with "RestrictionEnzyme"	     #
# replaced with  "RestrictionEnzyme_Q3"      #
##############################################

