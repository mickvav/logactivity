#!/usr/bin/perl
if($#ARGV>-1) {
   open(FD,"<$ENV{HOME}/.logactivity/logfile.".$ARGV[0]) or die "Can't open logfile.$ARGV[0]\n";
} else {
   open(FD,"<$ENV{HOME}/.logactivity/logfile") or die "Can't open logfile\n";
};

my @myarray=();
my %myhash=();
while(<FD>) {
  chomp;
#  Пн июл 17 11:52:07 MSK 2017 12 mick@linux
  if(/^(\d+) (\d+) (.*)$/) {
    # Format ok.
    if(defined($myhash{$3})) {
      $myhash{$3}+=$2;
    } else {
      $myhash{$3}=$2;
      push @myarray,$3;
    };
  };
};

my @a2=sort {$myhash{$a} <=> $myhash{$b} } @myarray ;
foreach my $e (@a2) {
  print $myhash{$e}."\t".$e."\n";
};

