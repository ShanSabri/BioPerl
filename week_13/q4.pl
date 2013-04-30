#!/opt/perl/bin/perl -w
use strict;
use Bio::SeqIO;

##########################################################################
# The script below functions to convert a sequence file (in any format)  #
# to any other format which BioPerl supports. The SeqIO module system 	 #
# handles many formats. Technically, the format parameter is options  	 #
# since SeqIO is smart enough to determine the file format based on its  #
# extention and/or content. If SeqIO is unable to determine the file 	 #
# format it falls back on the FASTA format.				 #
##########################################################################

if ($#ARGV != 1 ) {
	print "USAGE:\n" . 
		"\t ./q4.pl <input_file> <output_file_format>\n" . 
		"\t e.g.: ./q4.pl sequence.gb fasta\n";
	exit;
}

my $in_file   = $ARGV[0];
my $out_format  = $ARGV[1];

my ($in_name) = $in_file =~ (/^(.*?)\./); 
my $out_file = $in_name . "." . $out_format;
 
print "INPUT         : " . $in_file . "\n";
print "OUTPUT FORMAT : " . $out_format . "\n";
 
my $input = Bio::SeqIO->new(
                            -file   => "<" . $in_file,
                            );
							 
my $output = Bio::SeqIO->new(
                            -file   => ">" . $out_file,
                            -format => $out_format
                            );
							 
while (my $inseq = $input->next_seq) {
	$output->write_seq($inseq);
	print "WROTE         : " . $out_file . "\n";
}
