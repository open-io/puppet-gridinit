# Class: gridinit::reload
#
# Class to reread and update gridinit with gridinit_cmd
#
class gridinit::reload inherits gridinit {

  if $::gridinit::no_exec {
    exec { 'gridinitctl_reload':
      command => $::gridinit::command_true,
    }
  }
  else {
    exec { 'gridinitctl_reload':
      command => "/bin/sleep 1 ; ${gridinit::exec_ctl} reload",
      require => Service[$gridinit::service_name],
    }
  }

}
