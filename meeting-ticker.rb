require 'rubygems'
require 'sinatra'
require 'dm-core'

class Float
  def round_to(decimals)
    (self * 10**decimals).round.to_f / 10**decimals
  end
end
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

# automatically create the post table
#Meeting.auto_migrate!

get '/' do
  @meetings=Meeting.all
  @meetings.each{ |m| puts m.inspect}
  @dollars=@meetings.inject(0){|dollars,m| dollars+=m.amount}.round_to(2)
  erb :index
end

post '/new' do
  erb :new
end

post '/' do
  puts params.inspect
  m=Meeting.new
  attendees_count=params[:attendees_count].to_i; duration=params[:duration].to_f;rate=params[:hourly_rate].to_f
  m.attributes= { :attendees_count=> attendees_count, :duration=>duration, :amount=> rate*duration* attendees_count/3600 ,:hourly_rate=>rate}
  m.created_at=DateTime.now
  m.save
  puts "saving #{m.inspect}"
end
