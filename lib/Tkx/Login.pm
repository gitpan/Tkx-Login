$Tkx::Login::VERSION='1.04';

use Tkx;
use strict;

package Tkx::Login;

sub askpass {
  my $gotpass = 0;

  my $mw = shift @_;
  my $text = shift @_;
  my $user = shift @_;
  my $pass = shift @_;

  my $win = $mw->new_toplevel();
  $win->g_wm_title("Login");

  $win->new_ttk__label(-text => $text )->g_grid if $text;

  $win->new_ttk__label(-text => "Username:" )->g_grid;

  my $name_entry = $win->new_ttk__entry(-textvariable => \$user);
  $name_entry->g_grid;

  $win->new_ttk__label(-text => "Password:" )->g_grid;

  my $pass_entry = $win->new_ttk__entry(-textvariable => \$pass, -show => '*');
  $pass_entry->g_grid;

  my $ok = $win->new_button(
    -text => 'Ok',
    -command => sub {
       #message("Got: ".$name_entry->get );
       $gotpass++;
       $win->g_destroy;
    },
  );
  $ok->g_grid;

  while ( $gotpass < 1 ) {
    Tkx::update();
  }

  return ( $user, $pass );
}

1;

=head1 SYNOPSIS:

Tkx::Login provides a simple login interface for Tkx applications. Given
a window value to extend, it opens a new window, queries for username and
password and returns the values.

=head1 USAGE:

  use Tkx::Login;
    
  my ($username,$password) = Tkx::Login::askpass($mainwindow,$message,$pre_user,$pre_password);

  Parameters:
  
  $mainwindow - Current MainWindow in your Tkx app. (required)
  $message - A text message to display in the login window. (optional)
  $pre_user - A value to pre-populate the username blank with. (optional)
  $pre_pass - A value to pre-populate the password blank with. This will be obscured with asterisks. (optional)

=head1 AUTHORSHIP:

  Tkx::Login v1.04 2012/03/27

  (c) 2012-2012, Phillip Pollard <bennie@cpan.org>
  Released under the Perl Artistic License