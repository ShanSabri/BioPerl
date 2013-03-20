package q8;

use strict;
use base 'Exporter';

our @EXPORT = qw(translate_dna rev_comp frame);


sub translate_dna {
    my($dna) = @_;
    $dna = uc $dna;
    my $protein = '';

    my(%amino_acid) = (
		'ATG'=>'M', # START CODON
		'TGG'=>'W',
		'TTC'=>'F','TTT'=>'F',
		'TAC'=>'Y','TAT'=>'Y',
		'TGC'=>'C','TGT'=>'C',
		'CAA'=>'Q','CAG'=>'Q',
		'AGC'=>'S','AGT'=>'S',
		'TTA'=>'L','TTG'=>'L',
		'AAC'=>'N','AAT'=>'N',
		'GAA'=>'E','GAG'=>'E',
		'AAA'=>'K','AAG'=>'K',
		'CAC'=>'H','CAT'=>'H',
		'GAC'=>'D','GAT'=>'D',
		'AGA'=>'R','AGG'=>'R',
		'ATA'=>'I','ATC'=>'I','ATT'=>'I',
		'TAA'=>'*','TAG'=>'*','TGA'=>'*', # STOP CODONS
		'TCA'=>'S','TCC'=>'S','TCG'=>'S','TCT'=>'S',
		'CCA'=>'P','CCC'=>'P','CCG'=>'P','CCT'=>'P',
		'CTA'=>'L','CTC'=>'L','CTG'=>'L','CTT'=>'L',
		'GTA'=>'V','GTC'=>'V','GTG'=>'V','GTT'=>'V',
		'ACA'=>'T','ACC'=>'T','ACG'=>'T','ACT'=>'T',
		'CGA'=>'R','CGC'=>'R','CGG'=>'R','CGT'=>'R',
		'GGA'=>'G','GGC'=>'G','GGG'=>'G','GGT'=>'G',
		'GCA'=>'A','GCC'=>'A','GCG'=>'A','GCT'=>'A');

	#Amino acids codes taken from <http://www.hgvs.org/mutnomen/codon.html>

	for(my $i=0; $i < (length($dna) - 2); $i += 3) {
		my $codon = substr($dna,$i,3);
		if(exists $amino_acid{$codon}){
			my $peptide = $amino_acid{$codon};
			$protein .= $peptide;
		}
	}
	
	
	if ($protein =~ /^[MWFYCQSLNEKHDRISPLVTRGA\*]/i){ 
		my $start = index($protein, 'M');
		my $stop = index($protein, '*');
		my $start_to_end;
	
		if($start != -1 && $stop != -1){
			$start_to_end = substr($protein, $start, $stop);
			return $start_to_end;
		}
	
		if($start != -1 && $stop == -1){
			$start_to_end = substr($protein, $start, length($protein));
			return $start_to_end;
		}
		
		if(($start == -1 && $stop == -1) || 
			$start == -1 && $stop != -1){
			return "";
		}
	}else{
		return "Invalid\n";
	}
}

sub rev_comp {
    my($dna) = @_;
	my $rev_comp = reverse $dna;
	$rev_comp =~ tr/ATCGatcg/TAGCtagc/;
	return($rev_comp);
}

sub frame {
    my($dna, $shift) = @_;
	if (!grep(/[B|D|E|F|H|I|J|K|L|M|N|O|P|Q|R|S|U|V|W|X|Y|Z]/i, $dna)){
		my $frame = substr($dna, $shift - 1);
		return $frame;
	}#else{
	 #	die ("Can't handle characters other than: A  T  C  G\n");
	 #}
}

1;

################testing#############

# my $seq = 'GATATGGCTTCATAAAGCCGAA';

# for (my $i=1; $i<4; $i++){
	# print "5' -> 3' Frame $i: ";   
	# $frame = frame($seq, $i);
	# $protein = translate_dna($frame);
	# print "$protein\n";
# }

# for (my $j=1; $j<4; $j++){
	# print "3' -> 5' Frame $j: ";   
	# $frame = frame(rev_comp($seq), $j);
	# $protein = translate_dna($frame);
	# print "$protein\n";
# }
