puts "Installing the Gem bundler -> http://github.com/wycats/bundler"
`gem install bundler`
puts "installing the required gems"
`gem bundle --update`
puts "Installing the database."
require 'rubygems'
require 'dm-core'
require File.join(File.dirname(__FILE__),'meeting')
# automatically create the post table
DataMapper.auto_migrate!

