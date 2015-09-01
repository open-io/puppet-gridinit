class gridinit::config inherits gridinit {

  # Path
  $required_path = [$gridinit::sysconfdird,$gridinit::spoolstatedir,$gridinit::sharedstatedir,$gridinit::logdir]
    file { $required_path:
      ensure => $gridinit::directory_ensure,
      owner  => $gridinit::user,
      group  => $gridinit::group,
      mode   => $gridinit::directory_mode,
    }

  unless $gridinit::no_exec {
    $notify = Class['gridinit::service']
  }

  # Files
  file { "${gridinit::sysconfdir}/${gridinit::project_name}.conf":
    ensure  => $gridinit::file_ensure,
    content => template('gridinit/gridinit.conf.erb'),
    owner   => $gridinit::user,
    group   => $gridinit::group,
    mode    => $gridinit::file_mode,
    notify  => $gridinit::notify,
  }

}
