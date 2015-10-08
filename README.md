# gridinit

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with [gridinit]](#setup)
    * [Beginning with [gridinit]](#beginning-with-[gridinit])
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

Official module to install, configure and run the gridinit from the OpenIO open source project on RedHat/CentOS/Fedora/Debian/Ubuntu using Puppet 3.7 and newer.

This module helps you deploy gridinit process control system and create configuration for processes.

## Setup

### Beginning with [gridinit]	

To install packages, deploy basic configuration and run gridinit, simply declare it:

```
class {'gridinit':}
```
To configure new processes controlled by gridinit, declare them using the following defined type:

```
gridinit::program { "myprocess1":
  command => '/usr/bin/myprocess1 -c /etc/my1.conf',
}
gridinit::program { "myprocess2":
  command => '/usr/bin/myprocess2 -c /etc/my2.conf',
}
```

## Reference

The following define type is available:  
* gridinit::program

## Limitations

The module works under the latest stable RedHat, CentOS and Fedora, Debian and Ubuntu (LTS & latest).

## Development

You can report issues or request informations using [GitHub](https://github.com/open-io/puppet-gridinit/issues).

## Release Notes/Contributors/Etc.

Author: Romain Acciari <romain.acciari@openio.io>  
Copyright (c) 2015, OpenIO.  
Released under Apache License v2.  
