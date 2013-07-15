module Gadfly
  module_function
  INIT_DIR = '/etc/init'

  def install_upstart_script(script_name)
    if script_name.nil?
      return puts('Usage: gadfly <name_of_script>')
    end

    script_name = script_name.gsub('.rb', '')

    raise('script not found') unless File.exists?("#{script_name}.rb")
    raise('upstart not installed') unless `start --version`.include?('upstart')

    start_script = <<-eos
#!/bin/bash

set -u
set -e

INIT_RBENV='export PATH=$PATH:$HOME/.rbenv/bin; eval "$(rbenv init -)"'

CMD="$INIT_RBENV; cd '#{Dir.pwd}'; bundle exec ruby #{script_name}.rb"

su - #{ENV['USER']} -c "$CMD";
    eos

    conf = <<-eos
description "#{script_name}"

start on (local-filesystems and net-device-up IFACE=eth0)
stop on runlevel [016]

console log
exec #{Dir.pwd}/start_script
    eos

    `bundle`

    File.open('start_script', 'w') { |f| f.write(start_script) }
    `chmod +x start_script`

    File.open("#{script_name}.conf", 'w') { |f| f.write(conf) }

    [ 'mkdir -p /var/log/upstart',
      "mv #{script_name}.conf #{INIT_DIR}",
      "chown root:root #{INIT_DIR}/#{script_name}.conf",
      "stop #{script_name}",
      "start #{script_name}",
    ].each { |c| system "sudo #{c}" }
  end
end