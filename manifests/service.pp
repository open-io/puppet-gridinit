# Class: gridinit::service
#
# Class for the gridinit service
#
class gridinit::service inherits gridinit {

  unless $no_exec {
    service { $gridinit::service_name:
      ensure     => $gridinit::service_ensure,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package[$gridinit::packages_names],
    }
  }

}
