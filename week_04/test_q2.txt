#! /opt/perl/bin/perl
  
use strict;
use warnings;
  
use q2 ('randLength');
  
my $p = 50;
my $q = 1;
print randLength ( $p ), "\n";
print randLength ( $p, $q ), "\n"; 

