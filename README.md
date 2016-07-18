# ebrc_java

## Overview

Installs one or more Java packages for EuPathDB BRC.

## Module Description

Java managment per EuPathDB BRC's specifications, with focus on official 
support of WDK-based websites.

Installs one or more java packages and drop a profile in /etc/profile.d/ to set
`$JAVA_HOME` and include `$JAVA_HOME/bin` in `$PATH`.

## Setup

### Setup Requirements

The desired RPMs must be in EuPathDB's yum repository and the YUM 
repository configured on the node.

## Usage

`include ::ebrc_java`

## Hiera parameters

  - `ebrc_java::packages` - list of packages to install. Use values suitable for 'yum install"
  
        ebrc_java::packages:
        - jdk-1.7.0_25-fcs
        - java-1.5.0-sun-devel

  - `ebrc_java::java_home` - The default value of `$JAVA_HOME`. Used in `/etc/profile.d/java.sh` to set `JAVA_HOME` and update `PATH` bash environment variables.

## See also

`

## Limitations

Requires a RHEL-based Linux distro. Only tested on CentOS.
