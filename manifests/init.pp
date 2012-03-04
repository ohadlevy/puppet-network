class network {

  service {'network': }

  case $::operatingsystem {
    'redhat','fedora','centos': { include network::redhat  }
    'ubuntu','debian'         : { include network::ubuntu  }
  }

}
