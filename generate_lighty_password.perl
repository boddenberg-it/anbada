
#!/usr/bin/perl
# https://redmine.lighttpd.net/projects/1/wiki/HowToBasicAuth

print "User: ";
$user = <>;
chomp $user;
$realm = "anbada";

use Term::ReadKey;
{
  ReadMode('noecho');
  print "Password: ";
  $password = ReadLine(0);
  chomp $password;
  print "\nPassword again: ";
  $password2 = ReadLine(0);
  chomp $password2;
  ReadMode('normal');
  print "\n";

  if($password ne $password2)
  {
    print "Passwords don't match\n";
    redo;
  }
}

print "$user:$realm:";
open(MD5, "|md5sum | cut -b -32") or die;
print MD5 "$user:$realm:$password";
close(MD5);
