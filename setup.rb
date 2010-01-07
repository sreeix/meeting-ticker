require 'rubygems'
require 'dm-core'
require File.join(File.dirname(__FILE__),'meeting')
# automatically create the post table
DataMapper.auto_migrate!

