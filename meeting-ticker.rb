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
  this_month_begin = DateTime.new(DateTime.now.year, DateTime.now.month, 1)
  this_month_end = (this_month_begin >> 1) -1
  last_month_end= this_month_begin -1
  last_month_begin = DateTime.new(last_month_end.year, last_month_end.month, 1) 
  @dollars_last_month = Meeting.all(:created_at.gt =>last_month_begin, :created_at.lt => last_month_end).inject(0){|dollars,m| dollars+=m.amount}.to_f.round_to(2)
  @dollars_this_month = Meeting.all(:created_at.gt =>this_month_begin, :created_at.lt => this_month_end).inject(0){|dollars,m| dollars+=m.amount}.to_f.round_to(2)
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
