#!/opt/puppet/bin/ruby

require_relative 'lib/statsd.rb'

ARGF.each do |line|
  parts = line.split(' ')
  Statsd::gauges(parts[0], parts[1])
end

