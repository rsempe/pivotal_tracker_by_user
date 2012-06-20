class Story

  ### Attributes ###

  attr_accessor :user, :points, :date, :iteration

  ### Instance Methods ###

  def initialize(user, points, date, iteration)
    @user, @points, @date, @iteration = user, points, date, iteration
  end

  ### Class Methods ###

  def self.group_by_iteration(stories)
    stories.group_by(&:iteration).sort_by { |array| array.first.to_i }
  end

  def self.group_by_user(stories)
    stories.group_by(&:user).sort_by(&:first)
  end

  def self.users(stories)
    users = []
    stories.group_by(&:user).each { |user, stories| users << user }
    users
  end

  def self.sum_points(stories, iterations)
    points = []
    stories.group_by(&:iteration).each { |iteration, stories| points << [stories.sum(&:points), iteration] }
    (iterations.collect(&:first) - points.collect(&:last)).each { |point| points << [0, point] } if points.size != iterations.size
    points.sort_by { |point| point.last.to_i }
  end

  def self.sum_total(stories)
    total = []
    Story.group_by_iteration(stories).each { |iteration, features| total << features.sum(&:points) }
    total
  end

end