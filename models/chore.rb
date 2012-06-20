require 'models/story'

class Chore < Story

  ### Instance Methods ###

  def initialize(user, date, iteration)
    super(user, date, iteration)
  end

end