#!/opt/perl/bin/perl
use strict;use warnings;
use DBI;

my ( $inFile, $dbFile ) = @ARGV;
$dbFile = "q1.db" unless defined $dbFile; 
$inFile = "sample-data.txt" unless defined $inFile;

open my $file, '<', $inFile or die "Could not open file: $inFile";
print "Reading data from $inFile\n";
my $entries = read_file($file);
close $file;
 
print "Creating database named $dbFile\n";
my $dbh = DBI->connect( "dbi:SQLite:dbname=$dbFile", "", "" );
 
print "Making tables\n";
make_tables($dbh);
 
print "Placing ", scalar @$entries, " sequences into $dbFile\n";
put_into_db( $entries, $dbh );
 
sub put_into_db {
	my ($entries, $dbh) = @_;
	foreach my $entry ( @{$entries} ) {
		my $sth = $dbh->prepare("INSERT INTO Gene VALUES (?, ?, ?, ?, ? ,?)");
		$sth->execute(@$entry{qw/name organism tissue start stop expression/});
 		
		foreach my $seq ( @{ $entry->{sequences} } ) {
			my $sth = $dbh->prepare("INSERT INTO Sequence VALUES(?,?)");
			$sth->execute( $entry->{name}, $seq );
		}
	}
}
 
sub make_tables {
	my ($dbh) = @_;
	$dbh->do("CREATE TABLE IF NOT EXISTS Gene(
		name 	   TEXT    NOT NULL PRIMARY KEY,
		organism   TEXT    NOT NULL,
		tissue 	   TEXT    NOT NULL,
		start 	   INTEGER NOT NULL,
		stop 	   INTEGER NOT NULL,
		expression INTEGER NOT NULL)"
	);
 
	$dbh->do("CREATE TABLE IF NOT EXISTS Sequence(
		gene_name  TEXT NOT NULL,
		sequence   TEXT NOT NULL,
		PRIMARY KEY(gene_name, sequence))"
	);
}
 
sub read_file {
	my ($fh) = @_;
	my @results;
	local $/ = "\n>";
	while ( my $read = <$file> ) {
		chomp($read);
		$read =~ s/^>//;
	        my ( $head, $sequences ) = split( /\n/, $read, 2 );
 		#Parse using an array of string indicies
		my %entry;
		@entry{qw/name organism tissue start stop expression/} = split /\|/, $head;
		$entry{sequences} = [];

		foreach my $sequence ( split "\n", $sequences ) {
			$sequence =~ s/^\s*//;    
			next if $sequence =~ /^;/;
			push @{ $entry{sequences} }, $sequence;
		}
 		push @results, \%entry;
	}
	return \@results;
}
