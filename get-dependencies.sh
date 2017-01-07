#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

rolesdir=$(dirname $0)/..

[ ! -d $rolesdir/juju4.golang ] && git clone https://github.com/juju4/ansible-golang $rolesdir/juju4.golang
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.mig-agentsbuild ] && ln -s ansible-mig-agentsbuild $rolesdir/juju4.mig-agentsbuild
[ ! -e $rolesdir/juju4.mig-agentsbuild ] && cp -R $rolesdir/ansible-mig-agentsbuild $rolesdir/juju4.mig-agentsbuild

## don't stop build on this script return code
true

