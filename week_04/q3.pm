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
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "randLength" );

my @bases = qw/ A C G T /;
my $length;

=back

=head1 CODE BODY

The subroutine below accounts for two arguments: one mandatory and one optional. If the second argument is defined then lenght will be a random integer between 1 and the original first length argument. If the second argument does not exist then the code only accounts for the first argument. For each position (1-length), the code will print out random bases from our array defined in the head.  

=over 5

=item CODE:
  
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

=back

=head1 AUTHOR

Shan Sabri <ShanASabri@gmail.com>

=cut
