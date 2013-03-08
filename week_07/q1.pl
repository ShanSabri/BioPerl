#!/opt/perl/bin/perl
use warnings;
use strict;
 
use DBI;
use Getopt::Std;

my $db_file = './db.db';
my $dbh = DBI->connect( "DBI:SQLite:dbname=$db_file" , "" , "" ,
                        { PrintError => 0 , RaiseError => 1 } )
   or die DBI->errstr;
   
our ($opt_o, $opt_t);
 
getopts('o:t:');
 
if(!defined $opt_o && !defined $opt_t)
{
  print "USAGE:\n
        ./FILENAME -o Organism\n
        ----------OR----------\n
        ./FILENAME -t Tissue\n\n";
  exit;
}
 
if(defined $opt_o){
        print "Searching organism field for $opt_o \n";
        my $sth = $dbh->prepare
			("
			SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
			     gene_organism_expression as goe,
			     gene_organism as go
                        WHERE o.name = 'Mus musculus' 
	                     AND g.id = go.gene_id
			     AND o.id = go.organism_id 
			     AND goe.id = go.id") 
			or die qq("Can't prepare $opt_o");       
        $sth->execute()
			or die qq("Can't execute $opt_o");

	if ($sth->rows < 0) {
		print "NO RESULTS FOR $opt_o\n";
	}else{
		print "RESULTS:\nGene\t Organism\t Expression Level\n";
		while((my($gene, $organism, $gene_organism_expression)) 
		  = $sth->fetchrow_array()){
			print "$gene\t $organism\t $gene_organism_expression \n";
		}

	# STUFF BELOW ALSO WORKS!
	#	while(my @row = $sth->fetchrow_array){
	#		print "\t@row\n";	
	#	}	
	}		
}


#if($opt_t){
#        print "optT is $opt_t \n";
#        my $sth = $dbh->prepare("
#                        SELECT
#                        FROM
#                        WHERE
#                        ");
#        $sth->execute();
#}
 
$dbh->disconnect();


#HELP
#http://www.felixgers.de/teaching/perl/perl_DBI.html
