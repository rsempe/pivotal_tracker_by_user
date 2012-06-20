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

stories, dates, output = [], []

FasterCSV.foreach(ARGV.first, :headers => true) do |row|
  unless (date = row["Accepted at"]).nil?
    user = row["Owned By"].nil? ? "Unassigned" : row["Owned By"]
    stories << Story.new(user, row["Estimate"].to_i, date, row["Iteration"])

    dates << Time.parse(row["Iteration End"])
  end
end

iterations = Task.group_by_iteration(stories)

output = Output.new(Task.users(stories).max_by(&:length))
output.number_of_iterations(iterations)
output.dates_of_iterations(dates.uniq!.sort)

Task.group_by_user(stories).each do |user, features|
  output.iterations_for_user(user, Story.sum_points(features, iterations))
end

output.iterations_total(Story.sum_total(stories))
