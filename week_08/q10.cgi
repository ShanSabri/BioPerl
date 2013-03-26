#! /opt/perl/bin/perl
 
use strict;
use warnings;
use DBI;
use 5.010;

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
	get_results($organism, $tissue, $gene, $exp);
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

	my( $organism, $tissue, $gene, $exp ) = @_;

	if($gene && $organism && $tissue && $exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE t.name = '$tissue'
                             AND o.name = '$organism'
			     AND g.name = '$gene'
			     AND goe.expression_level == '$exp'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
	}

	elsif($gene && $organism && $tissue && !$exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE t.name = '$tissue'
                             AND o.name = '$organism'
                             AND g.name = '$gene'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	elsif($gene && $organism && !$tissue && $exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE o.name = '$organism'
                             AND g.name = '$gene'
                             AND goe.expression_level == '$exp'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	elsif($gene && !$organism && $tissue && $exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE t.name = '$tissue'
                             AND g.name = '$gene'
                             AND goe.expression_level == '$exp'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	elsif(!$gene && $organism && $tissue && $exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE t.name = '$tissue'
                             AND o.name = '$organism'
                             AND goe.expression_level == '$exp'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	elsif($gene && $organism && !$tissue && !$exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE o.name = '$organism'
                             AND g.name = '$gene'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	elsif($gene && !$organism && $tissue && !$exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE t.name = '$tissue'
                             AND g.name = '$gene'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	elsif($gene && !$organism && !$tissue && $exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE g.name = '$gene'
                             AND goe.expression_level == '$exp'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	elsif(!$gene && $organism && $tissue && !$exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE t.name = '$tissue'
                             AND o.name = '$organism'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	if(!$gene && $organism && !$tissue && $exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE o.name = '$organism'
                             AND goe.expression_level == '$exp'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }
	
	elsif(!$gene && !$organism && $tissue && $exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE t.name = '$tissue'
                             AND goe.expression_level == '$exp'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

 	elsif($gene && !$organism && !$tissue && !$exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE g.name = '$gene'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

 	elsif(!$gene && $organism && !$tissue && !$exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE o.name = '$organism'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	elsif(!$gene && !$organism && $tissue && !$exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE t.name = '$tissue'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	elsif(!$gene && !$organism && !$tissue && $exp){
                my $sth = $dbh->prepare("
                        SELECT g.name, o.name, expression_level
                        FROM gene as g, organism as o,
                             gene_organism_expression as goe,
                             gene_organism as go, tissue as t
                        WHERE goe.expression_level == '$exp'
                             AND g.id = go.gene_id
                             AND o.id = go.organism_id
                             AND goe.id = go.id
                             AND t.id = goe.tissue_id")
                        or die qq("Can't prepare search for $tissue");
                $sth->execute()
                        or die qq("Can't execute search for $tissue");
                my $results = undef;
                while ((my($gene, $organism, $gene_organism_expression))
                            = $sth->fetchrow_array()){
                        if (!$results){
                                print "RESULTS:\n";
                                $results = 1;
                        }
                        print "//\t$gene\t$organism\t$gene_organism_expression\n// ";
                }
                print "* NOT FOUND *\n" if !$results;
        }

	elsif(!$gene && !$organism && !$tissue && !$exp){
                print "* NO INPUT *\n";
        }
}
