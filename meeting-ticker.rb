require 'rubygems'
require 'sinatra'
require File.join(File.dirname(__FILE__),'meeting')

class Float
  def round_to(decimals)
    (self * 10**decimals).round.to_f / 10**decimals
  end
end

get '/' do
  @meetings=Meeting.all
  @dollars=@meetings.inject(0){|dollars,m| dollars+=m.amount}.to_f.round_to(2)
  erb :index
end

post '/new' do
  erb :new
end

post '/' do
  m=Meeting.new
  attendees_count=params[:attendees_count].to_i; duration=params[:duration].to_f;rate=params[:hourly_rate].to_f
  m.attributes= { :created_at => DateTime.now,:attendees_count => attendees_count, :duration => duration, :amount => rate*duration* attendees_count/3600 ,:hourly_rate => rate}
  m.save
  puts "saving #{m.inspect}"
end
