=pod

=head1 Q3

Modify the module from the previous question by adding documentation (in POD format) to explain the two ways the function can be called and the different results of each.

=head1 DESCRIPTION

This module contains a subroutine called randLength which takes an argument ($length)for length of the random nucleotide sequences to be returned. An optional second argument ($random_length) will cause the function to produce a sequence of a random length between 1 and the first argument.

=head1 CODE HEADING

The code below defines the exporting function to be used. 'randLength' is to be exproted on request. In addition to the exporting fucntion we have basic definations such as an array of nucleotide bases (@bases) and some user defined length ($length).

=over 5

=item CODE:

package q3;

use strict;
use base 'Exporter';

our @EXPORT = qw(randLength);

my @bases = qw/ A C G T /;
my @dna;

=back

=head1 CODE BODY

The subroutine below accounts for two arguments: one mandatory and one optional. If the second argument is defined then lenght will be a random integer between 1 and the original first length argument. If the second argument does not exist then the code only accounts for the first argument. For each position (1-length), the code will print out random bases from our array defined in the head.

=over 5

=item CODE:


sub randLength {

	@dna = ('');

	my $length = shift
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

=back

=head1 AUTHOR

Shan Sabri <ShanASabri@gmail.com>

=cut

#Code is the same as q2 except I've changed the package name

package q3;

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



