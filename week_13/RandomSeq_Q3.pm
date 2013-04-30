package RandomSeq_Q3;

# CONSTRUCTOR
sub new {
	my($class , %attribs) = (@_);
	my $self = {length => $attribs{length} || die("Need 'length'!")};
	return bless $self , $class;
}

# METHOD
sub random_protein{
	my $self = shift;
	my $seq;
	my @aa = qw(A C D E F G H I K L M N P Q R S T V W Y);
	for(my $i=0; $i<$self->{length}; $i++){
        $seq .= $aa[rand(@aa)];
    }
    return $seq;
}

# DECONSTRUCTOR
sub DESTROY {
	my( $self ) = ( @_ );
	print "RandomSeq_Q3::DESTROY called.\n";
	$self->{length} = undef if ($self->{length});
	print "Object handles are destroyed.\n";
}

1;
