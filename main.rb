# coding: utf-8
require 'time'
require 'active_support'
require 'active_support/core_ext'
require 'net/http'
require 'json'
require 'nkf'

default_date = (DateTime.now + 1.day).strftime('%Y-%m-%d')

puts "main.rb #{default_date} 7 19-22 10-12-19-22"

def fetch_japanese_holiday
  res = Net::HTTP.get_response(
    URI.parse("https://holidays-jp.github.io/api/v1/#{DateTime.now.year}/date.json")
  )
  JSON.parse(NKF.nkf('-w', res.body))
end

start = ARGV[0] || default_date
days = (ARGV[1] || 7).to_i
hours = (ARGV[2] || '19-22').to_s.split('-').map(&:to_i).sort
holiday_hours = (ARGV[3] || ARGV[2] || '10-12-19-22').to_s.split('-').map(&:to_i).sort

japanes_holidays = fetch_japanese_holiday

WEEK_NAME = %w[日 月 火 水 木 金 土].freeze

days.times do |count|
  time = DateTime.parse(start) + count.day
  holiday_key = time.strftime('%Y-%m-%d')
  d = time.day
  m = time.month
  target_hours = hours
  target_hours = holiday_hours if [0, 6].include?(time.wday) || japanes_holidays[holiday_key]
  target_hours.each do |h|
    puts "#{m}/#{d}(#{WEEK_NAME[time.wday]}) #{h}:00〜"
  end
end
