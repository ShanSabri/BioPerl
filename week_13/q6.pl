#!/opt/perl/bin/perl 
use warnings;
use strict;

#####################################################################
# The script below takes a protein sequence accession number  and   #
# e-value cutoff from the user and performs the appropriate BLAST   #
# search. The retrieved hits are then written out to a file named   #
# by hit accession number to the current directory. Each output     #
# record contains the essential values such as: 		    #
#		- RANK						    #
#		- HIT NAME					    #
#		- ACCESSION NUMBER				    #
#		- LENGTH					    #
# 		- SCORE						    #
#		- IDENTITY					    #
#		- E-VALUE					    #
# as well as the corresponding string alignment. If no hits 	    #
# satisfy the e-value cutoff, then the script will notify the user  #
# and not output a record will be written. 			    #
#####################################################################

use Bio::SearchIO;
use Bio::DB::GenBank;
use Bio::Tools::Run::RemoteBlast;

STDOUT->autoflush(1);

if ($#ARGV != 1 ) {
	print "USAGE:\n" . 
			"\t ./q6.pl <accession_number> <e-value_cutoff>\n" . 
			"\t e.g.: ./q6.pl YP_005233920 1E-52\n";
	exit;
}
 
my $accession = $ARGV[0]; 
my $e_value = $ARGV[1];

# my $accession = 'YP_005233920';
# my $e_value = '1e-52';

my $db = Bio::DB::GenBank->new();
my $factory = Bio::Tools::Run::RemoteBlast->new( 
				-prog       => 'blastp'  ,
				-data       => 'nr'      ,
				-expect     => $e_value  ,
				-readmethod => 'SearchIO' );

my $seq = $db->get_Seq_by_acc($accession);	
print "Submitting BLAST..."; 
$factory->submit_blast($seq);
print "DONE\n";
print "Gathering Results";
while (my @rids = $factory->each_rid){
	foreach my $rid (@rids){
		my $results = $factory->retrieve_blast($rid);
		if(!ref($results)){print "."; sleep 5;}
		elsif($results<0){$factory->remove_rid($rid);}
		else{ 
			print "DONE\n";
			$factory->remove_rid($rid);
			my $result = $results->next_result;
			my @hits;
			while( my $hit = $result->next_hit ) {push (@hits, $hit);}
			if (!@hits){print "No hits satisfy the e-value cutoff!\n"; exit;}
			else{
				my $i = 1;
				foreach my $h (@hits) {
					my $file = $h->accession . ".txt";
					open (FILE, ">$file") or die $!;
					while ( my $hsp = $h->next_hsp ) {
						print FILE 
							"RANK: #"     . $hsp->rank               . "\n"      .
							"HIT: "       . $h->name 		 . "\n"      . 
							"ACCESSION: " . $h->accession            . "\t"      .
							"LENGTH: "    . $hsp->length('hit')      . "\t"      .
							"SCORE: "     . $hsp->bits               . " bits\t" .
							"IDENTITY: "  . $hsp->percent_identity   . "%\t"     .
							"E-VALUE: "   . $hsp->evalue             . "\n"      ;
						printf FILE ("%10s: %s\n" , "Query" , $hsp->query_string)    ;
						printf FILE ("%10s: %s\n" , ""      , $hsp->homology_string) ;
						printf FILE ("%10s: %s\n" , "Sbjct" , $hsp->hit_string)      ;
					}
					close (FILE);
					print "Output record for hit #" . $i . 
						  " can be found in: " . $file . "\n"; 
					$i++;					
				}
			}
			print scalar @hits . " Results Total!\n";
		}
	}
}
