package q2;

use strict;
use base 'Exporter';

our @EXPORT = qw(randLength);

my @bases = qw/ A C G T /;
my @dna;

sub randLength {
  	@dna = ('');
	my $length = shift;
	my $random_length = shift;
	
	if ( $random_length ) {
                $length = int( rand( $length ));
        }

	foreach (1 .. $length){
  		push (@dna, $bases[int(rand(4))]);
	}

	my $dna = join "", @dna;
	return $dna;
}

1;
