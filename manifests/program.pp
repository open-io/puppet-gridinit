# Define: gridinit::program
#
# This define creates a program configuration file
#
#
define gridinit::program(
  $command,
  $action        = 'create',
  $enabled       = true,
  $start_at_boot = 'yes',
  $on_die        = 'respawn',
  $group         = undef,
  $environment   = undef,
  $uid           = undef,
  $gid           = undef,
  $env_path      = '/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin',
  $no_exec       = false,
) {

  if ! defined(Class['gridinit']) {
    class {'gridinit':
      no_exec => $no_exec,
    }
  }

  # Should have validation here

  unless $no_exec {
    $file_notify = [Exec['gridinitctl_reload'],Exec[$name]]
  }

  # Config file
  file { "${gridinit::sysconfdird}/${name}":
    ensure  => $gridinit::file_ensure,
    content => template('gridinit/program.erb'),
    owner   => $gridinit::user,
    group   => $gridinit::group,
    mode    => $gridinit::file_mode,
    notify  => $gridinit::file_notify,
  }

  unless $no_exec {
    # Start and restart program
    exec { $name:
      command => "${gridinit::exec_ctl} start ${name}",
      refresh => "${gridinit::exec_ctl} restart ${name}",
      require => Exec['gridinitctl_reload'],
    }
  }

}
