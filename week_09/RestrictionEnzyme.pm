package RestrictionEnzyme;

use Moose;

has 'name' => (isa => 'Str', is => 'rw');
has 'manufacturer' => (isa => 'Str', is => 'rw');
has 'recognition_sequence' => (isa => 'Str', is => 'rw', required => 1);

# METHOD
sub cut_dna{
	my $self = shift;
	my $dna = shift;
	my $enzyme_seq = $self->recognition_sequence;
	
	print "Using " . $self->name . " from " . $self->manufacturer .
		" with a recognition sequence of " . $self->recognition_sequence . "\n";
	print "Using DNA: $dna\n";
	my %frags = ();
	if($enzyme_seq =~ m{([^'])'([^/])}) {
		 %frags = (
			'pre' => $1, 
			'post' => $2
			); 
		my $pre = $frags{'pre'};
		my $post = $frags{'post'};
		while(1){
			if ($dna =~ s/(.*${pre})(${post}.*)/$1/ ) {
				unshift @{$frags{''}}, $2;
			}else{
				unshift @{$frags{''}}, $dna;
				return @{$frags{''}};
				last;
			}	
		}
	}else{
		return "Enzyme has no cut site!\n";
		exit;
	}
}	
	
1;

#####################################
###### Q2 - POD documentations ######
#####################################

=head1 SYNOPSIS

Using Moose, the class 'RestrictionEnzyme' will create an object of enzyme
and cut a DNA sequence given by argument and return an array of 
digested DNA fragments.


=head1 Attributes and Constraints

Each object that is created has three attributes:
	
	- Name
	- Manufacture
	- Recognition Sequence

These attributes have constraints on being:
	
	- Strings
	- Read and Write
	- Required (Recognition Sequence)
	

=head1 cut_dna()

This object method takes a sequence as an argument and returns an 
array of digested DNA fragments. First the method checks to verify 
the format of the enzyme recognition sequences. This sequence should 
contain an apostrophe to denote the enzyme cut site; if not, no 
significant results are returned. The fragments are located prior
to the apostrophe [pre(cuts)] and after the apostrophe [post(cuts)].
As the DNA is being read, fragments are unshifted from the sequence
and placed into an array. When pre- and post-cuts can no longer be 
substituted the array is returned.


=head1 AUTHOR

Shan Sabri <ShanASabri@gmail.com>

=cut
