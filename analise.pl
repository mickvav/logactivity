#!/usr/bin/perl

# Translates seconds into hour:minute:seconds
sub hms($) {
  use integer;
  my $sfull=@_[0];
  my $mfull=$sfull/60;
  my $hfull=$mfull/60;
  return sprintf("%d:%02d:%02d",$hfull,$mfull % 60, $sfull % 60);
};
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
  print $myhash{$e}."\t(".hms($myhash{$e}).")\t".$e."\n";
};

