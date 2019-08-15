# == Class: ebrc_java
#
# Manages Java installation for given $package name
#
# === Parameters
#
#  $package - name of java package to install, e.g. jdk-1.7.0_80
#  $java_home - full path to JAVA_HOME, e.g. /usr/java/jdk1.7.0_80
#  $default_ver - /usr/java/default symlink points to this directory in
#  /usr/java. This symlink is originally created by the Oracle RPM. "By
#  /default, usr/java/default points to /usr/java/latest. However, if
#  /administrators change /usr/java/default to point to another version
#  /of Java, subsequent package upgrades will be provided by the
#  /administrators and cannot be overwritten."
#   - http://www.oracle.com/technetwork/java/javase/install-linux-rpm-137089.html
#
# === Authors
# Mark Heiges <mheiges@uga.edu>
#
class ebrc_java (
  $packages,
  $java_home,
  $default_ver = '/usr/java/latest',
  $truststore = ''
) {

  package { $packages :
    ensure  => installed,
  }

  file { '/etc/profile.d/java.sh':
    ensure  => present,
    content => template('ebrc_java/java.sh'),
    require => Package[$packages],
  }

  if $default_ver != undef {
    file { '/usr/java/default':
      ensure => 'link',
      target => $default_ver,
    }
  }

  file { '/etc/.java/gusjvm.properties':
    ensure  => present,
    content => template('ebrc_java/gusjvm.properties')
  }

  # because old tomcats expect this path to exist, we create the link here.
  # can be removed when we are on a modern tomcat (RM 37205)
  if $java_home == "/usr/lib/jvm/jre-11" {
    file { "${java_home}/lib/amd64":
      ensure => link,
      target => '.',
      force  => false,
    }
  }

}
