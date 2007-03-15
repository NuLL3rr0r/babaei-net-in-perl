#!/usr/bin/perl
use strict;
use CGI ':standard';
use CGI::Carp 'fatalsToBrowser';
use Switch 'fallthrough';
use utf8;
use encoding 'utf-8';
use XML::Simple;
use Data::Dumper;

print "Content-Type: text/html; charset=utf-8\n\n";

my $xml = new XML::Simple;
my $dwndlist = $xml->XMLin("../restricted/articles.reg", forcearray => 1);
my $xmlp = $xml->XMLout($dwndlist);

$dwndlist = $dwndlist->{"dwnd"};
foreach (@$dwndlist) {
	print qq(,,,,,,,,,,,,,,,,,,,,,,,,,,* My Contacts,* ,$_->{"target"},,,,,,,,,,,,<br /> );
}
