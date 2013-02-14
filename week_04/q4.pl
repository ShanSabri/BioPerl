#! /opt/perl/bin/perl

use strict;
use warnings;

#Run 2 tests, one for each argument. 
use Test::Simple tests => 1;

use q2 'randLength';

my $length = 50;
my $dna = randLength(50);
#my $random_length = 1;

#ok ( length($dna)  == 50 , "string length checks" );
ok ( $dna =~ /^[ACGT]{$length}$/i , "string composition checks" );
