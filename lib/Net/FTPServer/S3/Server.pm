# -*- cperl -*-

# ABSTRACT: An FTP server with Amazon S3 backend

package Net::FTPServer::S3::Server;

use strict;

use Net::FTPServer;
use Net::FTPServer::S3::FileHandle;
use Net::FTPServer::S3::DirHandle;

use vars qw(@ISA);
@ISA = qw(Net::FTPServer);

=pod

=over 4

=item $rv = $self->authentication_hook ($user, $pass, $user_is_anon)

Perform login against C<database>.

=cut

sub authentication_hook
  {
    my $self = shift;
    my $user = shift;
    my $pass = shift;
    my $user_is_anon = shift;

    return -1 if $user_is_anon; # we don't allow anonymous users

    if ( ($user eq 'lorenzo' && $pass eq 'lorenzo') ||
         ($user eq 'tineke' && $pass eq 'tineke') ||
         ($user eq 'jesper' && pass eq 'jesper') ) {
      # Successful login.
      return 0;
    }

    # login failed
    return -1;
  }

=pod

=item $self->user_login_hook ($user, $user_is_anon)

Hook: Called just after user C<$user> has successS3y logged in.

=cut

sub user_login_hook
  {
    my $self = shift;
    my $user = shift;
    my $user_is_anon = shift;

  }

=pod

=item $dirh = $self->root_directory_hook;

Hook: Return an instance of Net::FTPServer::S3DirHandle
corresponding to the root directory.

=cut

sub root_directory_hook
  {
    my $self = shift;

    return new Net::FTPServer::S3::DirHandle ($self);
  }

1 # So that the require or use succeeds.

__END__

=back

=head1 AUTHORS

Lorenzo Dierykcx

=head1 COPYRIGHT

Lorenzo Dieryckx

=head1 SEE ALSO

C<Net::FTPServer(3)>,
C<Authen::PAM(3)>,
C<Net::FTP(3)>,
C<perl(1)>,
RFC 765,
RFC 959,
RFC 1579,
RFC 2389,
RFC 2428,
RFC 2577,
RFC 2640,
Extensions to FTP Internet Draft draft-ietf-ftpext-mlst-NN.txt.

=cut
