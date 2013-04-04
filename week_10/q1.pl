#!/opt/perl/bin/perl
use strict;
use warnings;

use Bio::Perl;
use Bio::Seq;

print "Input File (dna.fasta or protein.fasta): ";
chomp (my $file = <STDIN>);
# my $file = 'protein.fasta'; 


my @bio_seq_objects = read_all_sequences( $file , 'fasta' );

my %seqInfo;
foreach my $seq( @bio_seq_objects ) {
	my $key = (split(/\|/, $seq->display_id))[0];
	my $val = $seq->seq;
	$seqInfo{$key} = $val;
}

if (keys %seqInfo) {
	print "Genes contained withing FASTA file: \n";
	print "\t$_\n" for (keys %seqInfo); 
	print "\nWhich gene(s) would you like to BLAST (ex: Gene1 Gene2 Gene3): \n"; 
	my @userinput = split(/\s+/, <>); 
	# my @userinput = qw[Nos2];
	
	my $i = 1;
	foreach my $arg (@userinput){
		if ($arg = $seqInfo{$arg}) {
			my %rhash = reverse %seqInfo;
			my $key = $rhash{$arg};
			# print $key . "\n"; # KEY - header
			# print $arg . "\n"; # VALUE - sequence
			my $seq_obj = Bio::Seq->new(-seq => $arg, -display_id => $key);	
			if ($seq_obj->alphabet() eq 'dna'){	
				# print "Sequence is of type DNA\n";
				my $prot_obj = $seq_obj->translate(); 
				my $blast = blast_sequence( $prot_obj );
				write_blast( ">".$key."_Blast_Results" , $blast );
				print "File: ".$key."_Blast_Results successfully created\n";
			}
			if ($seq_obj->alphabet() eq 'protein'){
				# print "Sequence is of type PROTEIN\n";
				my $blast = blast_sequence( $seq_obj );
				write_blast( ">".$key."_Blast_Results" , $blast );
				print "File: ".$key."_Blast_Results successfully created\n";
			}
		}else{print "ERR: Did not find Gene$i in $file!\n";$i++;}
	}
}else{print "ERR: No Genes found in $file!\n";}
