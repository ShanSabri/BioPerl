package Math;

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "add" );

sub add {
	my ( $x, $y ) = @_;
	return $x + $y;
}
1;
