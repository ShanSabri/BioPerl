#!/opt/perl/bin/perl
use strict;
use warnings;

use Modern::Perl;
use Bio::DB::GenBank;
use Bio::Tools::Run::RemoteBlast;

STDOUT->autoflush(1);

print "Accession No.: ";
chomp (my $accession = <STDIN>);

my $db = Bio::DB::GenBank->new();

my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => 'blastp'   ,
                                                 -data       => 'nr'       ,
                                                 -expect     => '1e-10'    ,
                                                 -readmethod => 'SearchIO' );

my $i = 1;
sub topHit{
	my $seq = shift;
	print "Submitting BLAST (Round $i)..."; $i++;
	$factory->submit_blast( $seq );
	print "DONE\n";
	print "Gathering Results..";
	while (my @rids = $factory->each_rid){
		foreach my $rid (@rids){
			my $results = $factory->retrieve_blast($rid);
			if(!ref($results)){
				print "."; sleep 5;
			}elsif( $results<0 ){
				$factory->remove_rid($rid);
			}else{ 
				$factory->remove_rid($rid);
				my $result = $results->next_result;
				while( my $hit = $result->next_hit ) {
					my $hitacc = $hit->accession;
					my $seqacc = $seq->accession;
					if ($hitacc ne $seqacc){return $hit; last;}
				}
			}
		}
	}
}

my $seq = $db->get_Seq_by_acc($accession);					
my $hit1 = topHit($seq);
my $hit1_accession = $hit1->accession;
print "\n\tTop Non-self Hit (Round 1)\n",
	  "\t\t- Accession: " , $hit1_accession , "\n\n"; 		

my $seq2 = $db->get_Seq_by_acc($hit1_accession);
my $hit2 = topHit($seq2);
my $hit2_accession = $hit2->accession;
my $hit2_obj = $db->get_Seq_by_acc($hit2_accession);
print "\n\tTop Non-self Hit (Round 2)\n",					
	  "\t\t- Accession: " , $hit2_accession, "\n", 
	  "\t\t- GI No.: "    , $hit2_obj->primary_id, "\n", 
	  "\t\t- Version: "   , $hit2_obj->seq_version, "\n", 
	  "\t\t- Locus: "     , $hit2_obj->display_id, "\n", 
	  "\t\t- Species: "   , $hit2_obj->species->binomial, "\n",
	  "\t\t- Length: "    , $hit2_obj->length, "\n", 
	  "\t\t- Molecule: "  , $hit2_obj->molecule, "\n"; 
	
print "\nNOTE: Top Non-self Hit for Round 2 is the same as the original" . 
		" input (" . $accession . ")\n" if ($accession eq $hit2_accession);
		
		
############
# Examples #
############
#	1: MATCH
#		Round 1 - Accession No.: 	NP_249765
#			  Top Non-self Hit:	YP_792195
#		Round 2 - Accession No.: 	YP_792195
#			  Top Non-self Hit: 	NP_249765
#	
#	2: NO MATCH
#		Round 1 - Accession No.: 	YP_005233920	
#			  Top Non-self Hit: 	NP_457320
#		Round 2 - Accession No.: 	NP_457320
#			  Top Non-self Hit: 	ZP_02656064

