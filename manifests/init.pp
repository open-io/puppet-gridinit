# == Class: gridinit
#
# Full description of class gridinit here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { gridinit:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Romain Acciari <romain.acciari@openio.io>
#
# === Copyright
#
# Copyright 2015      OpenIO
#

class gridinit(
  $project_name             = $gridinit::params::project_name,
  $prefixdir                = $gridinit::params::prefixdir,
  $libdir                   = $gridinit::params::libdir,
  $bindir                   = $gridinit::params::bindir,
  $sysconfdir               = $gridinit::params::sysconfdir,
  $sysconfdird              = $gridinit::params::sysconfdird,
  $localstatedir            = $gridinit::params::localstatedir,
  $runstatedir              = $gridinit::params::runstatedir,
  $spoolstatedir            = $gridinit::params::spoolstatedir,
  $sharedstatedir           = $gridinit::params::sharedstatedir,
  $logdir                   = $gridinit::params::logdir,
  $exec_ctl                 = $gridinit::params::exec_ctl,
  $user                     = $gridinit::params::user,
  $user_ensure              = $gridinit::params::user_ensure,
  $uid                      = $gridinit::params::uid,
  $group                    = $gridinit::params::group,
  $group_ensure             = $gridinit::params::group_ensure,
  $gid                      = $gridinit::params::gid,
  $package_ensure           = $gridinit::params::package_ensure,
  $packages_names           = $gridinit::params::packages_names,
  $logfile_maxbytes         = $gridinit::params::logfile_maxbytes,
  $logfile_backups          = $gridinit::params::logfile_backups,
  $log_level                = $gridinit::params::log_level,
  $service_ensure           = $gridinit::params::service_ensure,
  $environment              = $gridinit::params::environment,
  $env_path                 = $gridinit::params::env_path,
  $enabled                  = $gridinit::params::enabled,
  $start_at_boot            = $gridinit::params::start_at_boot,
  $on_die                   = $gridinit::params::on_die,
  $file_mode                = $gridinit::params::file_mode,
  $file_ensure              = $gridinit::params::file_ensure,
  $directory_mode           = $gridinit::params::directory_mode,
  $directory_ensure         = $gridinit::params::directory_ensure,
  $limit_core_size          = $gridinit::params::limit_core_size,
  $limit_max_files          = $gridinit::params::limit_max_files,
  $limit_stack_size         = $gridinit::params::limit_stack_size,
  $no_exec                  = $gridinit::params::no_exec,

  $programs                 = {},
) inherits gridinit::params {

  # Should have some validation here
  validate_string($project_name)
  validate_absolute_path($prefixdir)
  validate_absolute_path($libdir)
  validate_absolute_path($bindir)
  validate_absolute_path($sysconfdir)
  validate_absolute_path($sysconfdird)
  validate_absolute_path($localstatedir)
  validate_absolute_path($runstatedir)
  validate_absolute_path($spoolstatedir)
  validate_absolute_path($sharedstatedir)
  validate_absolute_path($logdir)
  validate_string($exec_ctl)
  validate_string($user)
  $valid_user_ensure = ['present','absent','role']
  validate_re($user_ensure,$valid_user_ensure,"${user_ensure} is invalid.")
  if type3x($uid) != 'integer' { fail("${uid} is not an integer.") }
  validate_string($group)
  $valid_group_ensure = ['present','absent']
  validate_re($group_ensure,$valid_group_ensure,"${group_ensure} is invalid.")
  if type3x($gid) != 'integer' { fail("${gid} is not an integer.") }
  $valid_package_ensure = ['present','installed','absent','purged','held','latest']
  validate_re($package_ensure,$valid_package_ensure,"${package_ensure} is invalid.")
  #validate_array($package_names)

  create_resources('gridinit::program', $programs)

  contain gridinit::install
  contain gridinit::config
  contain gridinit::reload
  contain gridinit::service

  unless $no_exec {
    Class['gridinit::config'] ~> Class['gridinit::reload']
  }

  Class['gridinit::config'] -> Gridinit::Program <| |>

}
