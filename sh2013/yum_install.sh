#!/bin/bash
# need to install the following software in the newly-built VPS (CentOS 6.4)
# BTW, when using 'yum install' you can use '-y' option answer any questions with 'yes'.
# -y, --assumeyes
#              Assume yes; assume that the answer to any question which would be asked is yes.

yum install vim
yum install openssh*
yum install openssh-client
yum install httpd
yum install mysql
yum install mysql-server
yum install php
yum install wget
yum install php-mysql
yum install iptraf
yum install iftraf
yum install iftop
yum install sysstat
yum install git
yum install bc
yum install mailx
yum install postfix

# use 'system-config-firewall-tui' to config firewall
yum install system-config-firewall-tui


# add more packages which have nothing to do with WordPress.
yum install pciutils
yum install svn
yum install glibc-common
yum install ntpdate
yum install gcc
yum install make

