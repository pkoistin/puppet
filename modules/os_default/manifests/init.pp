class os_default {
  include os_default::cron
  include os_default::facter
  include os_default::misc
  include os_default::ntp
  include os_default::optimizations
  include os_default::sudo

  #$packages = [ 'foo', 'bar' ]
  #package { $packages: ensure => installed }
}
