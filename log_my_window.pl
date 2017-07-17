#!/usr/bin/perl
use strict;
use POSIX qw(setsid);
use Fcntl qw(:flock);

if ( ! -d $ENV{HOME}."/.logactivity") {
  mkdir $ENV{HOME}."/.logactivity";
};

open(FD,">".$ENV{HOME}."/.logactivity/logfile") or die "Can't open logfile.";
flock(FD,LOCK_EX) or die "Can't lock logfile.";

my $pid = fork();
die "can't fork: $!" unless defined $pid;
exit 0 if $pid;
setsid();
open (STDIN, "</dev/null");
open (STDOUT, ">/dev/null");
open (STDERR,">&STDOUT");

my $d=time();
my $N=`xdotool getwindowfocus getwindowname`;

my  ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($d);

$| =1; # Disable output buffering.

while( 1 == 1 ) {
  sleep(5);
  my $d1=time();
  my  ($sec,$min,$hour,$mday1,$mon1,$year1,$wday,$yday1,$isdst) = localtime($d);
  my $N1=`xdotool getwindowfocus getwindowname`;
  if (($N ne $N1) or ($yday1 != $yday) ) {
    my $spent=$d1-$d;
    print FD "$d1 $spent $N";
    $d=$d1;
    $N=$N1;
  };
  if($yday1 != $yday) {
    close(FD);
    rename($ENV{HOME}."/.logactivity/logfile",$ENV{HOME}."/.logactivity/logfile.".$year."-".$mon."-".$mday1);
    $mon=$mon1;
    $year=$year1;
    $yday=$yday1;
    $mday=$mday1;
    open(FD,">".$ENV{HOME}."/.logactivity/logfile"); 
  };
};
