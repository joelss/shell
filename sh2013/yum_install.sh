#!/bin/bash
# need to install the following software in the newly-built VPS (CentOS 6.4)

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
