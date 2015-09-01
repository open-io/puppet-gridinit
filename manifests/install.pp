class gridinit::install inherits gridinit {
   # User
#  user { $gridinit::user:
#    ensure => $gridinit::user_ensure,
#    uid     => $gridinit::uid,
#    require => Group[$gridinit::group],
#  }
  # Group
#  group { $gridinit::group:
#    ensure => $gridinit::group_ensure,
#    gid    => $gridinit::gid,
#  }

  package { $gridinit::packages_names:
    ensure        => $gridinit::package_ensure,
    provider      => $gridinit::package_provider,
    allow_virtual => false,
  } 

}
