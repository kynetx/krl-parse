#!/usr/bin/perl -w
use strict;

use Getopt::Std;
use LWP::UserAgent;
use HTTP::Request;
use URI::Escape;

use Data::Dumper;

# global options
use vars qw/ %opt /;
my $opt_string = '?hf:';
getopts( "$opt_string", \%opt ) or usage();

usage() if $opt{'h'} || $opt{'?'};

my $krl_file = $opt{'f'};

# get the KRL file to validate
my $ruleset;
if (-e $krl_file) {
  local $/;
  open(KRL, $krl_file);
  $ruleset = <KRL>;
  close(KRL)
    or warn "Unable to close the file handle: $!";
} else {
  die "File $$krl_file not found";
}

# print $ruleset;


# my $krl_validate_url = "http://requestb.in/vgdgqkvg";

my $krl_validate_url = "http://kibdev.kobj.net/manage/validate/";

my $parameters = ['flavor' => 'json',
#		  'rule' => uri_escape($ruleset)
		  'rule' => $ruleset
		  ];

my $ua = LWP::UserAgent->new(); 
my $response = $ua->post($krl_validate_url, $parameters);
my $content = $response->content;

print $content;

1;



#
# Message about this program and how to use it
#
sub usage {
    print STDERR << "EOF";

Validates a KRL ruleset

usage: $0 [-h?] -f filename

 -h|?       : this (help) message
 -f file    : input file

example: $0 -f a16x565.krl

EOF
    exit;
}
