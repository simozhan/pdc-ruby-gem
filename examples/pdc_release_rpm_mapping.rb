#!/usr/bin/env ruby

require './lib/pdc'

def main
  PDC.configure do |config|
    config.site = 'https://pdc.engineering.redhat.com'
    config.log_level = :debug
    config.disable_caching = true
  end

  mapping = PDC::V1::ReleaseRpmMapping.where(
    release_id: 'ceph-2.1-updates@rhel-7', package: 'ceph'
  ).first
  puts mapping.mapping, ' ok'
end

main if $PROGRAM_NAME == __FILE__
