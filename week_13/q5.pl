#!/opt/perl/bin/perl 
use warnings;
use strict;

######################################################################
# The script below functions to take the user parameters:            #
#	 - search algorithm					     #
#	 - molecule type					     #
#	 - accession number					     #
# to perform a correct blast search. A series of conditionals are    #
# used to perform checks to detect when two arguments do not match.  #
# The resulting blast output file is named by the query sequence and #
# the search algorithm and can be found in the local directory.      #
######################################################################

use Bio::SearchIO;
use Bio::DB::GenBank;
use Bio::Tools::Run::RemoteBlast;

STDOUT->autoflush(1);

# my $prog = 'blastp';
# my $type =  'protein';
# my $accession = 'YP_005233920';

if ($#ARGV != 2 ) {
	print "USAGE:\n" . 
			"\t ./q5.pl <search_type> <data_type> <accession_number>\n" . 
			"\t e.g.: ./q5.pl blastp protein YP_005233920\n";
	exit;
}

my $prog	  = $ARGV[0]; 
my $type	  = $ARGV[1]; 
my $accession = $ARGV[2]; 

if ($prog !~ /blastn|blastx|tblastx|blastp|tblastn/i){
	print "ERROR: " . $prog . " is of an incorrect search type\n"; exit;
}elsif ($type !~ /dna|protein/i){
	print "ERROR: " . $type . " is of an incorrect data type\n"; exit;
}elsif ($type =~ /dna/i && $prog !~ /blastn|blastx|tblastx/i){
	print "ERROR: Arguments ($type AND $prog) do not match\n"; exit;
}elsif ($type =~ /protein/i && $prog !~ /blastp|tblastn/i){
	print "ERROR: Arguments ($type AND $prog) do not match\n"; exit;
}else{
	my $db = Bio::DB::GenBank->new();
	my $factory = Bio::Tools::Run::RemoteBlast->new( 
			-prog       => $prog     ,
			-data       => 'nr'      ,
			-expect     => '1e-10'   ,
			-readmethod => 'SearchIO' );

	my $seq = $db->get_Seq_by_acc($accession);	
	print "Submitting BLAST...";
	$factory->submit_blast($seq);
	print "DONE\n";
	print "Gathering Results";
	while (my @rids = $factory->each_rid){
		foreach my $rid (@rids){
			my $results = $factory->retrieve_blast($rid);
			if(!ref($results)){print "."; sleep 3;}
			elsif( $results<0 ){$factory->remove_rid($rid);}
			else{ 
				print "DONE\n";
				$factory->remove_rid($rid);
				my $result = $results->next_result;
				my $report = $result->query_name . "_" . $prog . ".txt";
				$factory->save_output($report);
				print "BLAST Report can be found in: " . $report . "\n";
			}
		}
	}
}
