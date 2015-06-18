class gridinit::config inherits gridinit {

  # Path
  $required_path = ["$sysconfdird","$spoolstatedir","$sharedstatedir","$logdir"]
#  if $action == 'create' {
    file { $required_path:
      ensure => $directory_ensure,
      owner => $user,
      group => $group,
      mode => $directory_mode,
    }
#  }

  unless $no_exec {
    $notify = Class['gridinit::service']
  }

  # Files
  file { "${gridinit::sysconfdir}/${gridinit::project_name}.conf":
    path    => "${gridinit::sysconfdir}/${gridinit::project_name}.conf",
    ensure  => "${gridinit::file_ensure}",
    content => template("gridinit/gridinit.conf.erb"),
    owner   => "${gridinit::user}",
    group   => "${gridinit::group}",
    mode    => "${gridinit::file_mode}",
    notify  => $notify,
  }

}
