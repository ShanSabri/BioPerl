#!/opt/perl/bin/perl

use strict;
use warnings;
 
my @tests = ('Word word word 24 word word word',  
             'Word word word -24 word word word',
	     'Word word word +24 word word word',
	     'Word word word 24.1 word word word', 
	     'Word word word -24.1 word word word',
	     'Word word word +24.1 word word word',
	     'Word word word 24.1e3 word word word', 
	     'Word word word -24.1e-3 word word word',
	     'Word word word +24.1E+3 word word word');

#Only integers 
print "Write a regular expression that will match a target string consisting only of an integer number.\n";
print "FOUND\tIN\n";
foreach (@tests) {($_ =~ /(\d+)/) ? print "$1\t$_\n" : print "No match\n";}

#Only integers and decimals
print "\nWrite one that will match a string containing only an integer or a decimal number.\n";
print "FOUND\tIN\n";
foreach (@tests) {($_ =~ /(\d+\.?\d*)/) ? print "$1\t$_\n" : print "No match\n";}

#Only +/- integers and decimals 
print "\nWrite one that will match a string containing a positive or negative integer or decimal number.\n";
print "FOUND\tIN\n";
foreach (@tests) {($_ =~ /([-+]\d+\.?\d*)/) ? print "$1\t$_\n" : print "No match\n";}

#Only scientific notation 
print "\nWrite one that will match a string containing only a positive or negative number in scientific notation\n";
print "FOUND\tIN\n";
foreach (@tests) {($_ =~ /([-+]?\d+\.?\d*[eE][-+]?\d+)/) ? print "$1\t$_\n" : print "No match\n";}

