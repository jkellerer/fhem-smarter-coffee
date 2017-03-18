#!/usr/bin/env perl
#
# Creates the content of "controls.txt".
#
# Usage: ./new-controls.pl > controls.txt
#
use File::stat;

# Enumerates the files to add or update.
my @files = (
    "FHEM/98_SmarterCoffee.pm"
);

# Creates the update entries
foreach $file (@files) {
    my $fileStat = stat($file);
    my ($sec,$min,$hour,$mday,$month,$year,$wday,$yday,$isdst) = localtime($fileStat->mtime);

    $year += 1900;
    $month += 1;

    print sprintf("UPD %04d-%02d-%02d_%02d:%02d:%02d %d %s\n",
        $year, $month, $mday, $hour, $min, $sec, $fileStat->size, $file);
}
