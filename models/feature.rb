require 'models/story'

class Feature < Story

  ### Attributes ###

  attr_accessor :points

  ### Instance Methods ###

  def initialize(user, points, date, iteration)
    super(user, date, iteration)
    @points = points
  end

  ### Class Methods ###

  def self.sum_points(features, iterations)
    points = []
    features.group_by(&:iteration).each { |iteration, features| points << [features.sum(&:points), iteration] }
    (iterations.collect(&:first) - points.collect(&:last)).each { |point| points << [0, point] } if points.size != iterations.size
    points.sort_by { |point| point.last.to_i }
  end

  def self.sum_total(features)
    total = []
    Story.group_by_iteration(features).each { |iteration, features| total << features.sum(&:points) }
    total
  end

end