#!/usr/bin/perl

use strict;
use utf8;
use HTML::Parser;

my $html;
do {
	local $/;
	binmode STDIN, ":utf8";
	$html = <STDIN>;
};

sub onstart {
	my ($tagname,$attr) = @_;
	$tagname eq 'a' or return;
	my $href = $attr->{href} or return;
	$href =~ m/\.kif$/ and printf "%s\n", $href;
}

my $p = HTML::Parser->new;
$p->handler(start => \&onstart, 'tagname,attr');
$p->parse($html);
$p->eof;

exit;
