#!/usr/bin/env ruby

require 'csv'

loans = CSV.read 'csvs/latest.csv'

# find indexes
headers = loans.first
@int_rate_index         = headers.index 'int_rate'
@exp_default_rate_index = headers.index 'exp_default_rate'

# insert header
headers.unshift 'net_return'

def net_return(loan)
  int_rate            = loan[@int_rate_index].to_f
  default_probability = loan[@exp_default_rate_index].to_f / 100.0
  average_percentage_salvaged = 50.0

  (1 - default_probability) * (100.0 + int_rate) + default_probability * average_percentage_salvaged - 100
end

loans[1..-1].each do |l|
  l.unshift net_return l
end

CSV.open("csvs/latest.csv", "wb") do |csv|
  loans.each do |l|
    csv << l
  end
end

