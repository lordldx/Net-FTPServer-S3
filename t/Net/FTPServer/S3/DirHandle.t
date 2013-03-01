use Test::MockObject::Extends;
use Test::More;
use Net::FTPServer;
use Net::Amazon::S3::Client::Bucket;
use Data::Stream::Bulk;

use_ok Net::FTPServer::S3::DirHandle;

# mock the ftp server
my $ftps = Net::FTPServer->new;
$ftps = Test::MockObject::Extends->new($ftps);

# mock the S3 bucket
my $bucket = Net::Amazon::S3::Client::Bucket->new;
$bucket = Test::MockObject::Extends->new($bucket);



# create the dirhandle
my $dirhandle = new_ok (Net::Amazon::FTPServer::S3::DirHandle => [$ftps, '/']);

# Test get
{
	# test get file
	{
		# Arrange
		my $path = 'testdir';

		my $stream = Test::MockObject::Extends->new(Data::Stream::Bulk->new);
		$stream->mock('is_done', 0);

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
		is_ok($result->{_pathname}, '/testdir/');
	}
}