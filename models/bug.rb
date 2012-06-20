require 'models/story'

class Bug < Story

  ### Instance Methods ###

  def initialize(user, date, iteration)
    super(user, date, iteration)
  end

end