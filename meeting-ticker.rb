require 'rubygems'
require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, "sqlite://#{Dir.pwd}/meetings.db")

class Meeting
    include DataMapper::Resource
    property :id, Serial
    property :attendees_count, Integer
    property :amount, String
    property :hourly_rate, Float
    property :duration, Float
    property :created_at, DateTime
end

# automatically create the post table
Meeting.auto_migrate! unless Meeting.table_exists?

get '/' do
  erb :index
end 