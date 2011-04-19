class network {

  service {"network": }

  case $operatingsystem {
    "Solaris":                  { include network::solaris }
    "redhat","fedora","centos": { include network::redhat  }
    "ubuntu","debian"         : { include network::ubuntu  }
  }

}
