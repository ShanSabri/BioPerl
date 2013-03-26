#!/opt/perl/bin/perl --
 
use strict;
use warnings;
use DBI;
use CGI (':standard');

 
my $title = 'Database Search';
print header,
start_html( $title ),
h1( $title );
 
if( param( 'Submit' )) {
	my $organism = param( 'organism' );
	my $tissue = param ( 'tissue' );
	my $gene = param ( 'gene' );
	my $exp = param ('exp');
	my @results = get_results($organism, $tissue, $gene, $exp);

	foreach (@results) {print "$_ ";}
}
 
my $url = url();
print start_form( -method => 'GET' , action => $url ),
  p("Organism: " . textfield (-name => 'organism')),
  p("Tissue: " . textfield (-name => 'tissue')),
  p("Gene: " . textfield (-name => 'gene')),
  p("Expression Level: " . textfield (-name => 'exp')),
  p( submit( -name => 'Submit' , value => 'Submit' )),

end_form(),
end_html();
 
sub get_results {
	my $db_file = './db.db';
	my $dbh = DBI->connect( "DBI:SQLite:dbname=$db_file" , "" , "" ,
        { PrintError => 0 , RaiseError => 1 } )
   		or die DBI->errstr;

	my( $organism, $tissue, $gene, $exp ) = '';
	( $organism, $tissue, $gene, $exp ) = @_;

	my $search = "SELECT g.name, o.name, expression_level
                  FROM gene as g, organism as o,
                      gene_organism_expression as goe,
                      gene_organism as go, tissue as t
                  WHERE g.id = go.gene_id
                  AND o.id = go.organism_id
                  AND goe.id = go.id
                  AND t.id = goe.tissue_id";
	
	$search .= " AND g.name = '$gene' " if $gene ne ""; 
	$search .= " AND o.name = '$organism' " if $organism ne "";
	$search .= " AND t.name = '$tissue' " if $tissue ne "";
	$search .= " AND goe.expression_level == '$exp' " if $exp ne "";
	
	if(!$gene && !$organism && !$tissue && !$exp){
        	$search = "";
		print "* NO INPUT *\n";
    	}
	
	my $sth = $dbh->prepare($search) or die qq("Can't prepare search");
	$sth->execute() or die qq("Can't execute search");
	         
    	my @results;

    	while (my @result = $sth->fetchrow_array()){
        	push (@results, @result);
    	}

	return @results;
  
    	$sth->finish();
    	$dbh->disconnect();
}

