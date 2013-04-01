package RestrictionEnzyme_Q3;

# CONSTRUCTOR
sub new {
	my( $class , %attribs ) = ( @_ );
	my $self = {
		_name => $attribs{name} || 'unknown',
		_manufacturer  => $attribs{manufacturer} || 'unknown',
		_recognition_sequence  => $attribs{recognition_sequence} || die("need 'recognition_sequence'!")
	};
	return bless $self , $class;
}

# METHOD
sub cut_dna{
	my( $self , $dna ) = @_;
	my $enzyme_seq = $self->{_recognition_sequence}; 
	print "Using " . $self->{_name} . " from " . $self->{_manufacturer} .
		" with a recognition sequence of " . $self->{_recognition_sequence} . "\n";
	print "Using DNA: $dna\n";
	my %frags = ();
	if($enzyme_seq =~ m{([^'])'([^/])}) {
		%frags = (
			'pre' => $1, 
			'post' => $2); 
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

# DECONSTRUCTOR
sub DESTROY {
	my( $self ) = ( @_ );
	print "RestrictionEnzyme_Q3::destroyed called.\n";
	$self->{_name} = undef if ($self->{_name});
	$sefl->{_manufacturer} = undef if ($self->{_manufacturer});
	$self->{_recognition_sequence} = undef if ($self->{_recognition_sequence});	
	print "Object handles are destroyed.\n";
}

1;

#####################################
######   POD documentations    ######
#####################################

=head1 SYNOPSIS

This class, 'RestrictionEnzyme_Q3' will create an object of enzyme
and cut a DNA sequence given by argument and return an array of 
digested DNA fragments.


=head1 new()

This method will take in three object attributes:

	- _name
	- _manufacturer
	- _recognition_sequence

These attributes will then be set to $self. The return of the bless() 
function is used to change the data type of the anonymous hash to $class 
and finally return the object with its assigned attributes. 


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


=head1 DESTROY()

This object method acts as an automatic garbage collector. Once the object 
is out of scope, DESTROY() will be called automatically and set each ojbect 
handle to undef. 


=head1 AUTHOR

Shan Sabri <ShanASabri@gmail.com>

=cut
