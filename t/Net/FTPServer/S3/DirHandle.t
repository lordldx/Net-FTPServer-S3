# -*- mode: cperl -*-
use Test::MockObject::Extends;
use Test::More;
use Net::FTPServer::S3::Server;
use Net::Amazon::S3;
use Net::Amazon::S3::Client;
use Net::Amazon::S3::Client::Bucket;
use Data::Stream::Bulk::Nil;

BEGIN {
use_ok(Net::FTPServer::S3::DirHandle);
}

# mock the ftp server
my $ftps = Net::FTPServer::S3::Server->new;
$ftps = Test::MockObject::Extends->new($ftps);

# mock S3
my $s3 = Net::Amazon::S3->new(aws_access_key_id => 'dummy',
                              aws_secret_access_key => 'dummy');
$s3 = Test::MockObject::Extends->new($s3);

# mock the S3 client
my $client = Net::Amazon::S3::Client->new(s3 => $s3);
$client = Test::MockObject::Extends->new($client);

# mock the S3 bucket
my $bucket = Net::Amazon::S3::Client::Bucket->new(client => $client,
                                                  name => 'dummy');
$bucket = Test::MockObject::Extends->new($bucket);

# fixed stubs
$ftps->{bucket} = $bucket;



# create the dirhandle
my $dirhandle = new_ok (Net::FTPServer::S3::DirHandle => [$ftps, '/']);

# Test get
{
	# test get file
	{
		# Arrange
		my $path = 'testdir';

		my $stream = Test::MockObject::Extends->new(Data::Stream::Bulk::Nil->new);
		$stream->mock('is_done', sub {0;});

		$bucket->mock('list', sub { 
			my ($self, $args) = @_;
			if ($args->{prefix} eq '/testdir/') {
				return $stream;
				}
			});

		# Act
		my $result = $dirhandle->get($path);

		# Assert
		isa_ok($result, 'Net::FTPServer::S3::DirHandle');
		is($result->{_pathname}, '/testdir/');
	}
}


done_testing();
