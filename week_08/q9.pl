#!/opt/perl/bin/perl

use Test::Simple tests => 5;
use strict;
use warnings;
use q8;

my $seq = 'GATATGGCTTCATAAAGCCGAA';
# my $bad_seq = 'GATATGGCTZTCATAAAGYCCGAA'; 

my $test_frame1 = translate_dna(frame($seq, 1));                   #Output: MAS*   (start, stop)
my $test_frame2 = translate_dna(frame($seq, 2));                   #Output:        (no start, no stop)
my $test_frame1_revcomp = translate_dna(frame(rev_comp($seq), 1)); #Output: MKPY   (start, no stop)
my $test_frame2_revcomp = translate_dna(frame(rev_comp($seq), 2)); #Output:	   (no start, stop)

ok ($test_frame1 =~ /^[MWFYCQSLNEKHDRISPLVTRGA\*]/i , "Amino acid composition checks for DNA sequence");
ok ($test_frame1 =~ /^[M].*[\*]$/i, "Frame 1 of sequence contains a Start AND STOP codon"); 
ok (($test_frame1_revcomp =~ /^[M]/i) && ($test_frame1_revcomp !~ /[\*]$/), 
			"Frame 1 of sequence revcomp contains a Start and no STOP codon"); 
ok ($test_frame2 eq "", "Frame 2 of sequence contains no protein tranlation");
ok ($test_frame2_revcomp eq "", "Frame 2 of sequence revcomp contains no protein tranlation");

# Module will die here because of non-nucs found in bad_seq
# my $test_bad_seq = translate_dna(frame($bad_seq, 1));

exit;

##############
####OUTPUT####
##############

# input: GATATGGCTTCATAAAGCCGAA

# expected output: 
# 5'3' Frame 1
# D Met A S Stop S R 	#should return MAS_ (start and stop - return everything in between )
# 5'3' Frame 2
# I W L H K A E 	#should return nothing (no start no stop)
# 5'3' Frame 3
# Y G F I K P 		#should return nothing (no start no stop)
# 3'5' Frame 1
# F G F Met K P Y	#should return MKPY (start but no stop - return everything past start)
# 3'5' Frame 2
# S A L Stop S H I	#should return nothing  (no start but stop )
# 3'5' Frame 3
# R L Y E A I 		#should return nothing (no start no stop)

# via http://web.expasy.org/cgi-bin/translate/dna_aa

# q8 output: 
# 5' -> 3' Frame 1: MAS*
# 5' -> 3' Frame 2: 
# 5' -> 3' Frame 3: 
# 3' -> 5' Frame 1: MKPY
# 3' -> 5' Frame 2: 
# 3' -> 5' Frame 3:

