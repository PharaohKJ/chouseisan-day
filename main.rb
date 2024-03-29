# coding: utf-8
require 'time'
require 'active_support'
require 'active_support/core_ext'
require 'net/http'
require 'json'
require 'nkf'

default_date = (DateTime.now + 1.day).strftime('%Y-%m-%d')

puts "main.rb #{default_date} 7 19-22 10-12-19-22"
puts 'paste to https://chouseisan.com'

# 休日情報を取得し、年ごとにキャッシュする
class Holidays
  def initialize
    @holiday_cache = {}
  end

  def fetch_japanese_holiday(year: nil)
    year = DateTime.now.year if year.nil?
    if @holiday_cache[year].nil?
      res = Net::HTTP.get_response(
        URI.parse("https://holidays-jp.github.io/api/v1/#{year}/date.json")
      )
      @holiday_cache[year] = JSON.parse(NKF.nkf('-w', res.body))
    end
    @holiday_cache[year]
  end
end

start = ARGV[0] || default_date
days = (ARGV[1] || 7).to_i
hours = (ARGV[2] || '19-22').to_s.split('-').map(&:to_i).sort
holiday_hours = (ARGV[3] || ARGV[2] || '10-12-19-22').to_s.split('-').map(&:to_i).sort

holidays = Holidays.new
WEEK_NAME = %w[日 月 火 水 木 金 土].freeze

days.times do |count|
  time = DateTime.parse(start) + count.day
  holiday_key = time.strftime('%Y-%m-%d')
  d = time.day
  m = time.month
  target_hours = hours
  japanese_holidays = holidays.fetch_japanese_holiday(year: time.strftime('%Y'))
  is_jholiday = japanese_holidays[holiday_key]
  target_hours = holiday_hours if [0, 6].include?(time.wday) || is_jholiday
  target_hours.each do |h|
    puts "#{m}/#{d}(#{WEEK_NAME[time.wday]}#{is_jholiday ? ':祝' : ''}) #{h}:00〜"
  end
end
