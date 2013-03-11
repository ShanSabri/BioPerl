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
        #print "-o arg is $opt_o\n";
        my $sth = $dbh->prepare
			("
			SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
			     gene_organism_expression as goe,
			     gene_organism as go
                        WHERE o.name = '$opt_o' 
	                     AND g.id = go.gene_id
			     AND o.id = go.organism_id 
			     AND goe.id = go.id") 
			or die qq("Can't prepare search for $opt_o\n");       
        $sth->execute()
			or die qq("Can't execute search for $opt_o\n");
	
	my $results = undef;
	while ((my($gene, $organism, $gene_organism_expression))
           = $sth->fetchrow_array()){
		if (!$results){
			print "RESULTS:\n\tGene\t Organism\t Expression Level\n";
			$results = 1;
		}
		print "\t$gene\t $organism\t $gene_organism_expression \n";
	}
	print "* NOT FOUND *\n" if !$results;
}


if(defined $opt_t){
        #print "-t arg is $opt_t\n";
        my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go,
			     tissue as t
                        WHERE t.name = '$opt_t'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
			     AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $opt_t");
        $sth->execute()
                        or die qq("Can't execute search for $opt_t");

	my $results = undef;
        while ((my($gene, $organism, $gene_organism_expression))
           = $sth->fetchrow_array()){
                if (!$results){
                        print "RESULTS:\n\tGene\t Organism\t Expression Level\n";
                        $results = 1;
                }
                print "\t$gene\t $organism\t $gene_organism_expression \n";
        }
        print "* NOT FOUND *\n" if !$results;
}

 
$dbh->disconnect();
