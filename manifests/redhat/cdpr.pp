class network::redhat::cdpr {

  #setup a local script to run after each time the network is initalized
  file {'/sbin/ifup-local':
    mode    => '0500',
    source  => 'puppet:///network/sbin/ifup-local',
    require => Service['network'],
  }
  package{'cdpr': before  => Service['network'] }
}
