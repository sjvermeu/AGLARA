# Gentoo OpenRC
Puppet::Type.type(:service).provide :openrc_hardened, :parent => :base do
  desc <<-EOT
    Support for Gentoo's OpenRC initscripts

    Uses rc-update, rc-status and rc-service to manage services.
    Integrates use of run_init for SELinux. Also uses runstatus
    to get status information with returncodes.

  EOT

  defaultfor :operatingsystem => :gentoo
  defaultfor :operatingsystem => :funtoo

  commands :runinit => '/usr/sbin/run_init'
  commands :rcservice => '/sbin/rc-service'
  commands :rcstatus  => '/bin/rc-status'
  commands :rcupdate  => '/sbin/rc-update'
  commands :runstatus => '/usr/local/sbin/runstatus'

  self::STATUSLINE = /^\s+(.*?)\s*\[\s*(.*)\s*\]$/

  def enable
    rcupdate('-C', :add, @resource[:name])
  end

  def disable
    rcupdate('-C', :del, @resource[:name])
  end

  # rc-status -a shows all runlevels and dynamic runlevels which
  # are not considered as enabled. We have to find out under which
  # runlevel our service is listed
  def enabled?
    enabled = :false
    rcstatus('-C', '-a').each_line do |line|
      case line.chomp
      when /^Runlevel: /
        enabled = :true
      when /^\S+/ # caption of a dynamic runlevel
        enabled = :false
      when self.class::STATUSLINE
        return enabled if @resource[:name] == $1
      end
    end
    :false
  end

  def self.instances
    instances = []
    rcservice('-C', '--list').each_line do |line|
      instances << new(:name => line.chomp)
    end
    instances
  end

  def restartcmd
    (@resource[:hasrestart] == :true) && [command(:runinit), command(:rcservice), @resource[:name], :restart]
  end

  def startcmd
    [command(:runinit), command(:rcservice), @resource[:name], :start, ';', command(:runstatus), @resource[:name]]
  end

  def start
    begin
      output = runinit(command(:rcservice), @resource[:name], :start)
    rescue Puppet::ExecutionFailure
      raise Puppet::Error, "Could not start service - #{output}"
    end

    begin
      runstatus(@resource[:name])
    rescue Puppet::ExecutionFailure
      raise Puppet::Error, "Could not start service - #{output}"
    end
  end

  def stopcmd
    [command(:runinit), command(:rcservice), @resource[:name], :stop]
  end

  def statuscmd
    ((@resource.provider.get(:hasstatus) == true) || (@resource[:hasstatus] == :true)) && [command(:runstatus), @resource[:name]]
  end

end
