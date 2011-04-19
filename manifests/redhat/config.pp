class network::redhat::config {
# Disable IPv6 by default
  file {
    "/etc/sysconfig/network": 
      content => template("network/redhat/network.erb"),
      require => Service["network"];
    "/etc/modprobe.conf": mode => 644, ensure => present;
  }

  Line { before => File["/etc/modprobe.conf"]}
  line { 
    "remove_ipv6":
      file => "/etc/modprobe.conf",
      line => "alias ipv6 off";
    "remove_ipv6_2":
      file => "/etc/modprobe.conf",
      line => "alias net-pf-10 off";
    "remove_ipv6_3":
      file => "/etc/modprobe.conf",
      line => "options ipv6 disable=1",
  }

  # define static network if static_network=dev is used

  if $static_network { 
    network::redhat::static-network{$static_network:}
  }
}
