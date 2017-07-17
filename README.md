# logactivity
Simple X11 focus window logger.

## Background idea: 

It should be quite simple to analise the things, on which you spend your time,
if just record window titles of the applications, which you are running all the day.

Than you can summarize the total amount of time, spent in particular application (or 
even browser tab - they tend to change title according to current page).

This application records all this data automatically and allows you to analise your 
most time-hungry applications.

Tested on Ubuntu. 

## Prerequisites:

Debian/Ubuntu:

  sudo apt-get install xdotool

CentOS/Fedora:

* Add EPEL repository (https://fedoraproject.org/wiki/EPEL)
* yum install xdotool  

## Run:
  
  ./log\_my\_window.pl

## Analise:

Today:

  ./analise.pl

Some other day:

  ./analise.pl 2017-07-12

## Terminate:

  killall -9 ./log\_my\_window.pl
