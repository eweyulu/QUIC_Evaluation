#! /usr/bin/perl

require "getopts.pl";
&Getopts('t:');

$timeint = 0.01;
if (defined($opt_t)) {
	$timeint = $opt_t;
}

$_ = <>;
($time, $bytes) = split;
$sum = 1;
$sumb = $bytes;

$timestart = int($time / $timeint) * $timeint;
$timenext = $timestart + $timeint;

while (<>) {
	($time, $bytes) = split;
#	print "time $time bytes $bytes\n";
	while ($time > $timenext) {
		$timeprev = $timenext - $timeint;
		$sumbscaled = $sumb *8 / $timeint / 1024 / 1024;
		print "$timeprev $sum\t$sumb\t$sumbscaled\tMBit/s\n";
		$timenext += $timeint;
		#print "	erhoehe timenext: $timenext\n:";
		$sum = 0;
		$sumb = 0;
	}
	$sum++;
	$sumb+= $bytes;
	#print "next $time $sum $timenext\n";
}

$timeprev = $timenext - $timeint;
$sumbscaled = $sumb * 8 / $timeint / 1024 /1024;
print "$timeprev\t$sum\t$sumb\t$sumbscaled\tMBit/s\n";

