# adds cisco discovery facts
cdprfile = "/var/tmp/cdpr-"
interfaces = Facter.value(:interfaces) || "eth0"

interfaces.split(",").each do |i|
  next unless File.exists?(cdprfile+i)
  s=File.read(cdprfile+i).split(/\s*value:\s*/)
  switch = s[1].split("\n")[0] unless s[1].nil?
  port = s[3].split("\n")[0] unless s[3].nil?
  unless port.nil? and switch.nil?
    Facter.add("switch_#{i}") {
      confine :operatingsystem => %w{RedHat Fedora}
      setcode { switch }
    }
    Facter.add("port_#{i}") {
      confine :operatingsystem => %w{RedHat Fedora}
      setcode { port }
    }
  end
end

# Add default gateway and default interface fact
# Linux
if File.exists?('/sbin/ip')
  %x{/sbin/ip route}.each_line do |line|
    if line =~ /.*default via (.*) dev (\w+).*/
      Facter.add("gateway") {
        confine :kernel => "Linux"
        setcode { $1 }
      }
      Facter.add("gateway_if") {
        confine :kernel => "Linux"
        setcode { $2 }
      }
    end
  end
end
