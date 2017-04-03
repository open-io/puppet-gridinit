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
  $limit         = {},
  $no_exec       = false,
) {

  if ! defined(Class['gridinit']) {
    class {'gridinit':
      no_exec => $no_exec,
    }
  }

  # Should have validation here
  validate_string($command)
  validate_bool($enabled)
  $valid_start_at_boot = ['yes','no']
  validate_re($start_at_boot,$valid_start_at_boot,"${start_at_boot} is invalid.")
  $valid_on_die = ['cry','respawn','exit']
  validate_re($on_die,$valid_on_die,"${on_die} is invalid.")
  validate_string($group)
  validate_string($environment)
  validate_string($uid)
  validate_string($gid)
  validate_string($env_path)
  validate_hash($limit)
  validate_bool($no_exec)

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
    notify  => $file_notify,
  }

  if $::gridinit::no_exec {
    exec { 'gridinitctl_reload':
      command => $::gridinit::command_true,
    }
  }
  else {
    # Start and restart program
    exec { $name:
      command => "${gridinit::exec_ctl} start ${name}",
      refresh => "${gridinit::exec_ctl} restart ${name}",
      require => Exec['gridinitctl_reload'],
    }
  }

}
