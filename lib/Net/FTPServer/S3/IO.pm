# -*- cperl -*-

=pod

=head1 NAME

Net::FTPServer::S3::IO - The S3 FTP server personality

=head1 SYNOPSIS

  use Net::FTPServer::S3::IO;

=head1 METHODS

=cut

package Net::FTPServer::S3::IO;

use Moose;

has 'Filehandle' => (is => 'ro',
		isa => 'Net::FTPServer::S3::FileHandle');

has 'Mode' => (is => 'ro',
	isa => 'Str');



__META__->make_immutable;

1;