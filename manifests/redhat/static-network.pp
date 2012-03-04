define network::redhat::static-network($enabled = 'yes') {

  file { "ifcfg-$name":
    path    => "/etc/sysconfig/network-scripts/ifcfg-$name",
    mode    => '0644',
    content => template('network/redhat/ifcfg-static.erb'),
    ensure  => $enabled ? {'yes' => present, default => absent },
    notify  => Service['network'],
  }

}
