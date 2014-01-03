#!/usr/bin/perl -w
use strict;

use Getopt::Std;
use LWP::UserAgent;
use HTTP::Request;
use URI::Escape;
use JSON -support_by_pp;

#use Data::Dumper;

# global options
use vars qw/ %opt /;
my $opt_string = '?hvf:';
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

my $krl_validate_url = "http://cs.kobj.net/manage/validate/";
my $krl_flush_url = "http://cs.kobj.net/ruleset/flush/";

my $parameters = ['flavor' => 'json',
#		  'rule' => uri_escape($ruleset)
		  'rule' => $ruleset
		  ];

my $ua = LWP::UserAgent->new(); 
my $response = $ua->post($krl_validate_url, $parameters);

#print $response->content;

my $json = JSON->new->allow_nonref;

my $content = $json->allow_singlequote->decode($response->content);

if ($content->{'status'} eq 'error') {
  print $content->{'result'}, "\n";
} elsif (($content->{'status'} eq 'success')) {
  if ($opt{'v'}) {
    $json = $json->pretty(1);
    $json = $json->indent_length(4);
    print $json->encode($content->{'result'}), "\n";
  } else {
    print "OK\n";
  }
} else {
  warn "Invalid content returned";
}


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
 -v         : be verbose (return parse tree)

example: $0 -f a16x565.krl

EOF
    exit;
}
