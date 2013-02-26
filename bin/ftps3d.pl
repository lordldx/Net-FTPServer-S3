#!/bin/perl

use strict;
use Net::FTPServer::S3::Server;

my $ftps = Net::FTPServer::S3::Server->run;
