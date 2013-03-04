package Net::FTPServer::S3::IO;

use Moose;

has 'Filehandle' => (is => 'ro',
		isa => 'Net::FTPServer::S3::FileHandle');

has 'Mode' => (is => 'ro',
	isa => 'Str');



__META__->make_immutable;

1;