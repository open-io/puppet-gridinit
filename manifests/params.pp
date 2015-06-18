# Class: gridinit::params
#
# Default parameters for gridinit
#
class gridinit::params {
  $project_name             = 'gridinit'
  # Path
  $prefixdir                = '/usr'
  case $::osfamily {
    'x86_64': { $libdir     = "${prefixdir}/lib64" }
    defaults: { $libdir     = "${prefixdir}/lib" }
  }
  $bindir                   = "${prefixdir}/bin"
  $sysconfdir               = "/etc"
  $sysconfdird              = "/etc/${project_name}.d"
  $localstatedir            = '/var'
  $runstatedir              = '/run/gridinit'
  $spoolstatedir            = "${localstatedir}/spool/${project_name}"
  $sharedstatedir           = "${localstatedir}/lib/${project_name}"
  $logdir                   = "${localstatedir}/log/${project_name}"
  $exec_ctl                 = "${bindir}/gridinit_cmd -S /run/gridinit/gridinit.sock"
  # Administration
  $user                     = 'root'
  $user_ensure              = 'present'
  $uid                      = '0'
  $group                    = 'root'
  $group_ensure             = 'present'
  $gid                      = '0'
  # Packages
  $package_ensure           = 'installed'
  $package_provider         = 'yum'
  $packages_names           = ['openio-gridinit','openio-gridinit-utils']
  # Logging
  $logfile_maxbytes         = '50MB'
  $logfile_backups          = '14'
  $log_level                = 'info'
  # Services
  $service_name             = 'gridinit'
  $service_ensure           = 'running'
  $action                   = 'create'
  $environment              = undef
  $env_path                 = '/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin'
  $enabled                  = true
  $start_at_boot            = 'yes'
  $on_die                   = 'respawn'
  # Files & directories
  $file_mode                = '0644'
  $file_ensure              = 'file'
  $directory_mode           = '0755'
  $directory_ensure         = 'directory'
  # Others
  $no_exec                  = false
}
