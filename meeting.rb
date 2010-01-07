require 'rubygems'
require 'dm-core'

DataMapper.setup(:default, 'mysql://root:p@ssw0rd@localhost/meeting_tracker')

#DataMapper::setup(:default, "sqlite://#{Dir.pwd}/meetings.db")


class Meeting
    include DataMapper::Resource
    property :id, Serial
    property :attendees_count, Integer
    property :amount, Float
    property :hourly_rate, Float
    property :duration, Float
    property :created_at, DateTime
end

