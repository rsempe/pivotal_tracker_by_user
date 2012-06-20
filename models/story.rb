class Story

  ### Attributes ###

  attr_accessor :user, :date, :iteration

  ### Instance Methods ###

  def initialize(user, date, iteration)
    @user, @date, @iteration = user, date, iteration
  end

  ### Class Methods ###

  def self.feature?(type)
    type == 'feature'
  end

  def self.bug?(type)
    type == 'bug'
  end

  def self.chore?(type)
    type == 'chore'
  end

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

end