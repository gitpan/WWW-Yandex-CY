#!/usr/bin/perl
use strict;
use WWW::Yandex::CY;

my $cy = WWW::Yandex::CY->new();
$cy->site('http://jobs.su');
my $print = $cy->print();
print $print;

