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
output.number_of_iterations(iterations)
output.dates_of_iterations(dates.uniq!.sort)

Story.group_by_user(features).each do |user, features|
  output.iterations_for_user(user, Feature.sum_points(features, iterations))
end

output.iterations_total(Feature.sum_total(features))
