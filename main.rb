# coding: utf-8
require 'time'
require 'active_support'
require 'active_support/core_ext'

puts 'main.rb 2020-01-01 7 19-22'

start = ARGV[0] || (DateTime.now + 1.day).strftime('%Y-%m-%d')
days = (ARGV[1] || 7).to_i
hours = (ARGV[2] || '19-22').to_s.split('-')

WEEK_NAME = %w[日 月 火 水 木 金 土]

days.times do |count|
  hours.each do |h|
    time = DateTime.parse(start) + count.day
    d = time.day
    m = time.month
    puts "#{m}/#{d}(#{WEEK_NAME[time.wday]}) #{h}:00〜"
  end
end
