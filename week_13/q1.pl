#!/opt/perl/bin/perl -w
use strict;

##########################################################################
# The script below will take the user input for protein sequence length  #
# and generate a random protein sequence of that length. If no input     #
# is provided, then the script will generate a random sequence           #
# ranging from 1-100. This script uses the Q1.pm module.                 #
##########################################################################

use q1 'random_protein';

my ($arg, $length, $result);

print "Length   : ";
chomp ($arg = <STDIN>);

if ($arg eq ''){$length = 1 + int(rand(100));}
elsif ($arg =~ /^\d+$/) {$length = $arg;}
else {print "Input must be of an integter value! (e.g., 212, 5, 42, etc.)\n"; exit;}

$result = random_protein($length);
print "Sequence : " . $result . "\n";
