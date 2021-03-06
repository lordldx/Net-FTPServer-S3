# -*- cperl -*-

=pod

=head1 NAME

Net::FTPServer::S3::FileHandle - The S3 FTP server personality

=head1 SYNOPSIS

  use Net::FTPServer::S3::FileHandle;

=head1 METHODS

=cut

package Net::FTPServer::S3::FileHandle;

use strict;

use Net::FTPServer::FileHandle;

use vars qw(@ISA);

@ISA = qw(Net::FTPServer::FileHandle);

=pod

=over 4

=item $dirh = $fileh->dir;

Return the directory which contains this file.

=cut

sub dir
  {
    my $self = shift;
  }

=pod

=item $fh = $fileh->open (["r"|"w"|"a"]);

Open a file handle (derived from C<IO::Handle>, see
C<IO::Handle(3)>) in either read or write mode.

=cut

sub open
  {
    my $self = shift;
    my $mode = shift;

  }

=pod

=item ($mode, $perms, $nlink, $user, $group, $size, $time) = $handle->status;

Return the file or directory status. The fields returned are:

  $mode     Mode        'd' = directory,
                        'f' = file,
                        and others as with
                        the find(1) -type option.
  $perms    Permissions Permissions in normal octal numeric format.
  $nlink    Link count
  $user     Username    In printable format.
  $group    Group name  In printable format.
  $size     Size        File size in bytes.
  $time     Time        Time (usually mtime) in Unix time_t format.

In derived classes, some of this status information may well be
synthesized, since virtual filesystems will often not contain
information in a Unix-like format.

=cut

sub status
  {
    my $self = shift;
  }

=pod

=item $rv = $handle->move ($dirh, $filename);

Move the current file (or directory) into directory C<$dirh> and
call it C<$filename>. If the operation is successful, return 0,
else return -1.

Underlying filesystems may impose limitations on moves: for example,
it may not be possible to move a directory; it may not be possible
to move a file to another directory; it may not be possible to
move a file across filesystems.

=cut

sub move
  {
    my $self = shift;
    my $dirh = shift;
    my $filename = shift;

    die if $filename =~ /\//;	# Should never happen.

  }

=pod

=item $rv = $fileh->delete;

Delete the current file. If the delete command was
successful, then return 0, else if there was an error return -1.

=cut

sub delete
  {
    my $self = shift;
  }

=item $link = $fileh->readlink;

If the current file is really a symbolic link, read the contents
of the link and return it.

=cut

sub readlink
  {
    my $self = shift;
  }

1 # So that the require or use succeeds.

__END__

=back

=head1 AUTHORS

Lorenzo Dieryckx

=head1 COPYRIGHT

Lorenzo Dieryckx

=head1 SEE ALSO

C<Net::FTPServer(3)>, C<perl(1)>

=cut
