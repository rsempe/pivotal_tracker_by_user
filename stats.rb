#!/usr/bin/ruby

require 'rubygems'
require 'fastercsv'
require 'active_support/core_ext/enumerable'
require 'time'
Dir['models/*.rb'].each { |file| require file }

if ARGV.length != 1
  puts "Usage: #{__FILE__} <Your CSV file>"
  exit
end

features, bugs, chores, dates = [], [], [], []

FasterCSV.foreach(ARGV.first, :headers => true) do |row|
  unless (date = row["Accepted at"]).nil?
    user = row["Owned By"].nil? ? "Unassigned" : row["Owned By"]
    case row['Story Type']
      when 'feature' then features << Feature.new(user, row["Estimate"].to_i, date, row["Iteration"])
      when 'bug' then bugs << Bug.new(user, date, row["Iteration"])
      when 'chore' then chores << Chore.new(user, date, row["Iteration"])
    end
    dates << Time.parse(row["Iteration End"])
  end
end

iterations = Story.group_by_iteration(features)
output = Output.new(Story.users(features).max_by(&:length))
dates = dates.uniq!.sort

output.number_of_iterations(iterations, dates)
output.global_info(dates, Feature.sum_total(features), Story.number_by_iteration(bugs), Story.number_by_iteration(chores))
output.features_info(dates, features, iterations)
output.bugs_info(dates, bugs, iterations)
output.chores_info(dates, chores, iterations)