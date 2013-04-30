#!/opt/perl/bin/perl -w
use strict; 
use RandomSeq_Q3;

#############################################################################
# The script below will take the user input for protein sequence length     #
# and generate a random protein sequence of that length. If no input        #
# is provided, then the script will generate a sequence ranging from 1-100. #
# NOTE: the functionality of this script is the same as in q1.pl. However,  #
# This script uses the RandomSeq_Q3 package to generate the random sequence #
# using OOP. 								    #
#############################################################################

my ($seq, $arg, $length, $result);

print "Length   : ";
chomp ($arg = <STDIN>);

if ($arg eq ''){$length = 1 + int(rand(100));}
elsif ($arg =~ /^\d+$/) {$length = $arg;}
else {print "Input must be of an integter value! (e.g., 212, 5, 42, etc.)\n"; exit;}

$seq = RandomSeq_Q3->new(length => "$length");
$result = $seq->random_protein($length);
print "Sequence : " . $result . "\n";
