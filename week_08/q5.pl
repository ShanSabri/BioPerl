#!/opt/perl/bin/perl

use strict;
use warnings;

sub calc_GC {
	my $sequence = $_[0];
	my @seq_array = split('',$sequence);
	my $count = 0;

	foreach my $nuc (@seq_array) {
		$count++ if $nuc =~ /[G|C]/i;
	}
	
	my $seq_length = $#seq_array + 1;
	my $gc = $count/$seq_length;	
	my $gc_percent = 100 * $gc;	
	return $gc_percent;
}

sub anneal_temp {
        my $sequence = $_[0];
        my @seq_array = split('',$sequence);
	my $temp = 0;

	foreach my $nuc (@seq_array) {
		$temp = $temp + 2 if $nuc =~ /[A|T]/i;
		$temp = $temp + 4 if $nuc =~ /[G|C]/i;
	}
	return $temp;
}


my $sequence = 'ATCCAGACTTACGAAGT';
my $gc_for_seq = calc_GC($sequence);
my $temp_for_seq = anneal_temp($sequence);

print "Annealing temp: $temp_for_seq degrees C\n";
print "GC content: $gc_for_seq%\n";
