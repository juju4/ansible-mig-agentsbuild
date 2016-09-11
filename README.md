[![Build Status](https://travis-ci.org/juju4/ansible-mig-agentsbuild.svg?branch=master)](https://travis-ci.org/juju4/ansible-mig-agentsbuild)
# MIG Agents build ansible role

Ansible role to build client package of MIG agents
Refer to [mig master role](https://github.com/juju4/ansible-mig) for complete integration.
http://mig.mozilla.org/

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.0

### Operating systems

Tested with vagrant on Ubuntu 14.04, Kitchen test with xenial, trusty and centos7

## Example Playbook

Just include this role in your list.
For example

```
- host: all
  roles:
    - mig-agentsbuild
```

## Variables

To use integrated configuration, you must provide other servers information and certificate/key/ca

```
mig_user: "_mig"
mig_home: "/home/{{ mig_user }}"

## agents building
mig_gover: 1.6.2
mig_gopath: "{{ mig_home }}/go"
mig_src: "{{ mig_gopath }}/src/mig.ninja/mig"

## agents config: need to retrieve agent.crt, agent.key, ca.crt
mig_api_host: localhost
mig_api_port: 1664
mig_rabbitmq_host: localhost
mig_rabbitmq_port: 5672
mig_rabbitmq_vhost: mig
mig_rabbitmq_agentpass: xxx
mig_rabbitmq_clientdir: "/home/{{ mig_user }}/client"
mig_rabbitmq_cadir: "/home/{{ mig_user }}/ca"
mig_rabbitmq_cacertcrt: "{{ mig_rabbitmq_cadir }}/ca.crt"

mig_url: "http://{{ mig_api_host }}"

## agent will use those proxy as rescue network access if direct access not working
#mig_proxy_list: '{`proxy.example.net:3128`, `proxy2.example.net:8080`}'
mig_proxy_list: ''

## only enable if files/information are available
#mig_client_investigators:
#    - { realname: "MIG Example investigator", fingerprint: 'C070C873FDC2B5284C1D60089D6B3D2F773F5860', pubkeyfile: "files/vagrant.asc", pubkey: "{{ lookup('file', 'files/vagrant.asc') }}", weight: 2 }
## Note: don't try to lookup on same line var or get:
##   UnicodeDecodeError: 'utf8' codec can't decode byte 0x99 in position 0: invalid start byte
## ex:
##    - { realname: 'MIG Dupont Investigator', fingerprint: "{{ lookup('file', 'tmp/dupont-fingerprint') }}", pubkeyfile: "tmp/dupont.asc", pubkey: "{{ lookup('file', gpg_pubkeyfile) }}", weight: 2 }

```

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/mig-agentsbuild
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/mig-agentsbuild/test/vagrant
$ vagrant up
$ vagrant ssh
```

## Troubleshooting & Known issues

* Windows packages
Only Ubuntu xenial has a wixl package. As such, it's the only platform which is building windows agent by default.

## License

BSD 2-clause

