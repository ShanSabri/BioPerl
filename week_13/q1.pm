package q1;
use strict;
use Exporter 'import';

our @EXPORT_OK = ("random_protein");
my @aa = qw(A C D E F G H I K L M N P Q R S T V W Y);

sub random_protein{
	my $length = shift;
	my $seq;
	for(my $i=0; $i<$length; $i++){
        $seq .= $aa[rand(@aa)];
    }
    return $seq;
}
