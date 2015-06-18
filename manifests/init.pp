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
  $package_provider         = $gridinit::params::package_provider,
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
  $no_exec                  = $gridinit::params::no_exec,

  $programs                 = {},
) inherits gridinit::params {

  # Validation

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
