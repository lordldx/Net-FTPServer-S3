# -*- cperl -*-

=pod

=head1 NAME

Net::FTPServer::S3::DirHandle - The S3 FTP server personality

=head1 SYNOPSIS

  use Net::FTPServer::S3::DirHandle;

=head1 METHODS

=cut

package Net::FTPServer::S3::DirHandle;

use strict;

use Net::FTPServer::DirHandle;

use vars qw(@ISA);

@ISA = qw(Net::FTPServer::DirHandle);

=pod

=over 4

=item $handle = $dirh->get ($filename);

Return the file or directory C<$handle> corresponding to
the file C<$filename> in directory C<$dirh>. If there is
no file or subdirectory of that name, then this returns
undef.

=cut

sub get
  {
    my $self = shift;
    my $filename = shift;
  }

=item $dirh = $dirh->parent;

Return the parent directory of the directory C<$dirh>. If
the directory is already "/", this returns the same directory handle.

=cut

sub parent
  {
    my $self = shift;

    my $parent = $self->SUPER::parent;
    bless $parent, ref $self;
    return $parent;
  }

=pod

=item $ref = $dirh->list ([$wildcard]);

Return a list of the contents of directory C<$dirh>. The list
returned is a reference to an array of pairs:

  [ $filename, $handle ]

The list returned does I<not> include "." or "..".

The list is sorted into alphabetical order automatically.

=cut

sub list
  {
    my $self = shift;
    my $wildcard = shift;

    # Convert wildcard to a regular expression.
    if ($wildcard)
      {
	$wildcard = $self->{ftps}->wildcard_to_regex ($wildcard);
      }

  }

=pod

=item $ref = $dirh->list_status ([$wildcard]);

Return a list of the contents of directory C<$dirh> and
status information. The list returned is a reference to
an array of triplets:

  [ $filename, $handle, $statusref ]

where $statusref is the tuple returned from the C<status>
method (see L<Net::FTPServer::Handle>).

The list returned does I<not> include "." or "..".

The list is sorted into alphabetical order automatically.

=cut

sub list_status
  {
    my $self = shift;

    my $arrayref = $self->list (@_);
    my $elem;

    foreach $elem (@$arrayref)
      {
	       my @status = $elem->[1]->status;
	       push @$elem, \@status;
      }

    return $arrayref;
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

=item $rv = $dirh->delete;

Delete the current directory. If the delete command was
successful, then return 0, else if there was an error return -1.

It is normally only possible to delete a directory if it
is empty.

=cut

sub delete
  {
    my $self = shift;

  }

=item $rv = $dirh->mkdir ($name);

Create a subdirectory called C<$name> within the current directory
C<$dirh>.

=cut

sub mkdir
  {
    my $self = shift;
    my $name = shift;

    die if $name =~ /\//;	# Should never happen.
  }

=item $file = $dirh->open ($filename, "r"|"w"|"a");

Open or create a file called C<$filename> in the current directory,
opening it for either read, write or append. This function
returns a C<IO::File> handle object.

=cut

sub open
  {
    my $self = shift;
    my $filename = shift;
    my $mode = shift;

    die if $filename =~ /\//;	# Should never happen.
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
