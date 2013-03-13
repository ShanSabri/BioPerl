#!/opt/perl/bin/perl

use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

my ($c, $f);

print "Temperature: \n";
my $temp = <STDIN>;
chomp($temp);

if (!looks_like_number($temp)){
	print "Temperature must be numeric! \n";
	exit 1;
}

print "Fahrenheit or Celcius: \n";
my $input = <STDIN>;
chomp($input);

if ($input ne 'Fahrenheit' && $input ne 'Celcius'){
	print "Invalid input! \n";
	exit 1;
}

if ($input eq 'Fahrenheit'){
	$c = ($temp - 32) * 5/9;
	print "$temp Fahrenheit =  $c Celsius\n";
}

if ($input eq 'Celcius'){
	$f = ($temp * 9/5) + 32;
	print "$temp Celsius = $f Fahrenheit\n"; 
}
