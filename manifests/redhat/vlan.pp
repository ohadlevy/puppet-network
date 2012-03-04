define network::redhat::vlan($phy_if = 'eth0', $vlan, $enabled = 'yes', $native = false) {

  File { 
    mode => 644,
    ensure => $enabled ? {'yes' => present, default => absent },
    notify => Service['network']
  }

  $if_name = $native ? {
    false => "${phy_if}.${vlan}",
    true  =>  $phy_if,
  }
  file { "ifcfg-vlan-$name":
    path    => "/etc/sysconfig/network-scripts/ifcfg-$if_name",
    content => template("network/redhat/ifcfg-vlan.erb"),
  }
  file { "ifcfg-bridge-$name":
    path    => "/etc/sysconfig/network-scripts/ifcfg-br${vlan}",
    content => template("network/redhat/ifcfg-bridge.erb"),
  }
}
