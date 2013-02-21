#! /opt/perl/bin/perl

use warnings;
use strict;
use CGI (':standard');

my $title = 'DNA vs Protein';

print header,

  start_html( $title ),

  h1( $title );


if( param( 'submit' )) {

  my $sequence  = param( 'sequence' );

  print p( "Your randomize sequence of type $sequence: "),

    '<ul>';

if ( param('sequence') eq "DNA" ){
                my @nuc = ('A','T','C','G');
                my $DNA;
                $DNA .= $nuc[rand @nuc] for 1..50;
                print li($DNA);
        }else{
                my @aa = ('A','R','N','D','Y',
                          'C','E','Q','V','G',
                          'H','I','L','K','M',
                          'F','P','S','T','W');
                my $Protein;
                $Protein .= $aa[rand @aa] for 1..50;
                print li($Protein);
        }

  print '</ul>',

    hr();

}

my $url = url();

print start_form( -method => 'GET' , action => $url ),

  p( "Which type of sequence would you like to generate: "  . radio_group( -name   => 'sequence' ,

                                         -values => [ 'DNA' , 'Protein' ] )),
  
  p( submit( -name => 'submit' , value => 'Submit' )),

  end_form(),

  end_html();
