package q2;

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "randLength" );
  
my @bases = qw/ A C G T /;
my $length = 50;
  
sub randLength {
    	my( $length , $random_length ) = @_;
  
	if ( $random_length ) {
		$length = int( rand( $length ));
	}
  
	foreach ( 1 .. $length ) {
		print $bases[int(rand(4))];
	}
	print "\n";
}

1;
