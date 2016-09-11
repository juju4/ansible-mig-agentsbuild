#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

rolesdir=$(dirname $0)/..

[ ! -d $rolesdir/golang ] && git clone https://github.com/juju4/ansible-golang $rolesdir/golang

