class Task

  ### Attributes ###

  attr_accessor :user, :date, :iteration

  ### Instance Methods ###

  def initialize(user, date, iteration)
    @user, @date, @iteration = user, date, iteration
  end

end