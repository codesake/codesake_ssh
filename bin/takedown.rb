#! /usr/bin/env ruby
# encoding: utf-8

require 'codesake_ssh'

DEFAULT_CONF_FILE ="./codesake_ssh.conf"

# TODO: add rainbow dependency
# TODO: add option parsing here
# TODO: add parameter checking

conf_file = nil # => it will be initialized with the -c flag
conf_file = DEFAULT_CONF_FILE if File.exists?(DEFAULT_CONF_FILE) 

Codesake::SSH::Config.read_conf(conf_file) # => it's a singleton we dont need to bind it to a variable
engine = Codesake::SSH::Takedown.new(ARGV[0])   # => we expect argument to be single IP address in dot notation or LANs using CIDR notation

puts "[*] takedown is starting at #{Time.now.strftime("%H:%m:%S")}"
results = engine.analyse
puts "[-] #{engine.count_compromised} compromised hosts" if engine.compromised?
puts "[-] no server compromised" unless engine.compromised?
puts "[*] shutting down at #{Time.now.strftime("%H:%m:%S")}"# .color(:white)
Kernel.exit(0)
