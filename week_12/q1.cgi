#!/opt/perl/bin/perl -w

use strict;
use CGI (':standard');
use Bio::DB::EUtilities;

my $title = 'Global Query Search';
print header,
start_html( $title ),
h1( $title );

if( param( 'Submit' )) {
        my $query = param( 'query' );
        my @results = get_results($query);

        print "<table border='1'>";
        print "<tr><td>Database</td><td>Count</td></tr>\n";
        my $i=1;
        for (0..$#results/2-1) {
                print "<tr><td>$results[$i+1]</td><td>$results[$i]</td></tr>";
                $i+=2;
        }
        print "</table>";
}

my $url = url();

print start_form( -method => 'GET' , action => $url ),
p("Query: " . textfield (-name => 'query')),
p( submit( -name => 'Submit' , value => 'Submit' )),

end_form(),
end_html();

sub get_results {
        my ($query) = @_;
        my $factory = Bio::DB::EUtilities->new(-eutil => 'egquery', -term  => $query);

        my (@db, @count, @results) = '';

        while (my $gq = $factory->next_GlobalQuery) {
                push (@db, $gq->get_database);
                push (@count, $gq->get_count);
        }

        @results = map {($_ , shift @count)} @db;
        return @results;
}
