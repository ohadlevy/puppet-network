class network::redhat::config {
  file {
    '/etc/sysconfig/network':
      content => template('network/redhat/network.erb'),
      require => Service['network'];
  }

  # define static network if static_network=dev is used

  if $::static_network {
    network::redhat::static-network{$::static_network:}
  }
}
