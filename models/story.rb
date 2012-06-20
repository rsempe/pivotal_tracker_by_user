class Story

  ### Attributes ###

  attr_accessor :user, :date, :iteration

  ### Instance Methods ###

  def initialize(user, date, iteration)
    @user, @date, @iteration = user, date, iteration
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

  def self.number_by_iteration(stories)
    Story.group_by_iteration(stories).collect { |i| i.last.count }
  end

end