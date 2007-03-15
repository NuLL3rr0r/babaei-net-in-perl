#!/usr/bin/perl
use strict;
use CGI ':standard';
use CGI::Carp 'fatalsToBrowser';
use Switch 'fallthrough';
use utf8;
use encoding 'utf-8';
use XML::Simple;
use Data::Dumper;
use Digest::MD5;
use MIME::Lite;
use lib "../restricted/cgi-lib";
use String;
use String::Random;
#use Mail::CheckUser qw(check_email);

require '../restricted/cgi_master.lib';

package main;

$main::req = param('req');
$main::type = param('type');

$main::id = param('id');
$main::targetmail = param('targetmail');
$main::cid = param('cid');
$main::fid = param('fid');

$main::from = param('mail');
$main::subject = param('subject');
$main::body = param('body');
$main::sender = param('sender');
$main::url = param('url');

if (FoundXSS() or BadRequest()) {
	AliceH();
}

if ($main::req eq "articles" and $main::cid ne "" and $main::fid ne "") {
	SecureDownload();
}

print $main::httpHeader;

CheckBrowser();

if ($main::req eq "comments") {
	SendComments();
}
if (($main::req eq "" or $main::type ne "ajax") and $main::targetmail eq '') {
	print ReadLayout();
}
else {
	print ReadPage();
}
