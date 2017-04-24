#!/usr/bin/env perl
#
# Creates the content of "controls.txt".
#
# Usage: ./new-changed.pl > CHANGED
#
use strict;
use File::Slurp;

# Read source
my @lines = split(/[\r\n]+/, read_file("./FHEM/98_SmarterCoffee.pm"));

# Creates the update entries
my $capture = 1;
foreach my $line (@lines) {
    $capture = 1 if (not $capture and $line =~ /^# v[0-9]+\.[0-9]+ - [0-9]{4}-[0-9]{2}-[0-9]{2}.*/);
    $capture = 0 if ($capture and $line =~ /^#{10}.+/);

    if ($capture and $line =~ /^#(.*)$/) {
        print "$1\n";
    }
}
