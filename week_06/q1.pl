#!/opt/perl/bin/perl
use strict;use warnings;
use DBI;

my ( $inFile, $dbFile ) = @ARGV;
$dbFile = "q1.db" unless defined $dbFile; 
$inFile = "sample-data.txt" unless defined $inFile;

open my $file, '<', $inFile or die "Could not open file: $inFile";
print "Reading input file: $inFile\n";
my $entries = read_from_file($file);
close $file;
 
print "Creating database: $dbFile\n";
my $dbh = DBI->connect( "dbi:SQLite:dbname=$dbFile", "", "" );
 
print "Creating tables\n";
create_tables($dbh);
 
print "Inserting ", scalar @$entries, " sequences into $dbFile\n";
insert_into_db( $entries, $dbh );
 
sub insert_into_db {
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
 
sub create_tables {
	my ($dbh) = @_;
	$dbh->do("CREATE TABLE IF NOT EXISTS Gene(
		name TEXT PRIMARY KEY,
		organism TEXT,
		tissue TEXT,
		start INTEGER,
		stop INTEGER,
		expression INTEGER)"
	);
 
	$dbh->do("CREATE TABLE IF NOT EXISTS Sequence(
		gene_name TEXT,
		sequence TEXT,
		PRIMARY KEY(gene_name, sequence))"
	);
}
 
sub read_from_file {
	my ($fh) = @_;
	my @results;
	local $/ = "\n>";
	while ( my $record = <$file> ) {
		chomp($record);
		$record =~ s/^>//;
	        my ( $header, $sequences ) = split( /\n/, $record, 2 );
 		#Parse using an array of string indicies
		my %entry;
		@entry{qw/name organism tissue start stop expression/} = split /\|/, $header;
		$entry{sequences} = [];

		foreach my $sequence ( split "\n", $sequences ) {
			$sequence =~ s/^\s*//;    #Remove leading whitespace
			next if $sequence =~ /^;/;    #Skip comment lines
			push @{ $entry{sequences} }, $sequence;
		}
 		push @results, \%entry;
	}
	return \@results;
}
