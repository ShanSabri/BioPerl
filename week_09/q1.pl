#! /opt/perl/bin/perl
use strict; 
use warnings;

use RestrictionEnzyme;

my $enzyme = RestrictionEnzyme->new(
		name => "EcoRI" , 
		manufacturer => "Promega" ,
		recognition_sequence => "G'AATTC"
		);

my $dna = 'AAAAAAAAGAATTCAAAAAAAAGAATTCAAAAAAA';

if ($dna =~ /^[AGCT]+$/i){
	my @results = $enzyme->cut_dna($dna); 
	my $frag = 1;
	if ($results[0] ne "Enzyme has no cut site!\n"){
		foreach (@results){print "Fragment #$frag: " . $_ . "\n"; $frag++;}
	}else{
		print "\nNo results found. Please verify that the enzyme has a cut pattern.\n";
	}
}else{
	print "DNA contains non-[ATCG] nucleotides!\n";
}
