class os_default {
  include os_default::cron
  include os_default::misc
  include os_default::ntp
  include os_default::optimizations
  include os_default::pacman
  include os_default::ssh
  include os_default::sudo

  $packages = [ 'atop', 'aura-bin', 'avahi', 'cv', 'dnsutils', 'ethtool', 'git', 'haveged', 'htop', 'iftop', 'mlocate', 'mtr', 'ncdu', 'net-tools', 'nethogs', 'nss-mdns', 'pkgstats', 'rsync', 'pkgfile' ]
  package { $packages: ensure => installed }

  service { ['atop', 'avahi-daemon', 'haveged', 'puppet']:
    ensure => running,
    enable => true,
  }

  file {
    '/root/.smbcreds':
      mode   => '0600',
      source => 'puppet:///modules/os_default/smbcreds';
  }

  exec { 'systemd-daemon-reload':
    command     => '/usr/bin/systemctl daemon-reload',
    refreshonly => true,
  }

}
