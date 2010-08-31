#!/usr/bin/env perl

# take the first command-line argument
$argc     = @ARGV;
$raw_word = $ARGV[0];

# filter trailing non-word character ,such as ',','.','-', etc
#$raw_word =~ /([a-zA-Z\-]+)/;
$raw_word =~ /(\S+)/;
$refined_word = $1;

# '-d' means run within scripts.
system( "sdcv -n " . " " . "$refined_word" );
