#! /usr/bin/perl

use Test::Simple tests => 1;
use strict;
use warnings;
use q2;

my $length = 10;
my $random_length = 1;
my $oneArg = randLength($length);
my $twoArg = randLength($length, $random_length);

print "One argument sequence = $oneArg\n";
print "Two argument sequence = $twoArg\n";

ok (length($oneArg) == $length , "String length checks for one arg");
ok (length($twoArg) <= $length , "String length checks for two arg");
ok ($oneArg =~ /^[ACGT]{$length}$/i , "String composition checks for one arg");
ok ($twoArg =~ /^[ACGT]/i , "String composition checks for two arg");
