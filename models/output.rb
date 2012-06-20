class Output

  ### Attributes ###

  attr_accessor :length_username

  ### Instance Methods ###

  def initialize(length_username)
    @length_username = length_username
  end

  def number_of_iterations(iterations, dates)
    puts "\n\e[36m#{iterations.size} Iterations from #{dates.first.strftime("%m/%d/%y")} to #{dates.last.strftime("%m/%d/%y")}\e[0m"
  end

  def global_info(dates, features, bugs, chores)
    puts "\n\e[4;35mGlobal statistics:\e[0m"
    dates_of_iterations(dates)
    points_total(features)
    bugs_total(bugs)
    chores_total(chores)
  end

  def features_info(dates, features, iterations)
    puts "\n\e[4;35mFeature Points statistics:\e[0m"
    dates_of_iterations(dates)
    Story.group_by_user(features).each do |user, features_list|
      iterations_for_user(user, Feature.sum_points(features_list, iterations))
    end
    points_total(Feature.sum_total(features))
  end

  def bugs_info(dates, bugs, iterations)
    puts "\n\e[4;35mBugs statistics:\e[0m"
    dates_of_iterations(dates)
    Story.group_by_user(bugs).each do |user, bugs_list|
      iterations_for_user(user, Story.number(bugs_list, iterations))
    end
    bugs_total(Story.total(bugs))
  end

  def chores_info(dates, chores, iterations)
    puts "\n\e[4;35mChores statistics:\e[0m"
    dates_of_iterations(dates)
    Story.group_by_user(chores).each do |user, chores_list|
      iterations_for_user(user, Story.number(chores_list, iterations))
    end
    chores_total(Story.total(chores))
  end

  ### Private Methods ###

  private

  def format_number(value, padding)
    color = (0..9).include?(value) ? "1;31" : (10..19).include?(value) ? "1;32" : "1;33"
    "\e[#{color}m#{value.to_s.ljust(padding)}\e[0m"
  end

  def format_user(user, padding)
    "\e[36m#{user.ljust(padding)}\e[0m"
  end

  def dates_of_iterations(dates)
    puts "\n#{format_user("Dates", length_username.length)} | #{dates.collect { |date| "\e[33m" + date.strftime("%m/%d").ljust(5) + "\e[0m"}.join(" | ")} |"
  end

  def iterations_for_user(user, points)
    puts "#{format_user(user, length_username.length)} | #{points.collect { |point| format_number(point.first, 5) }.join(" | ")} |"
  end

  def points_total(points)
    puts "#{format_user("Total Points", length_username.length)} | #{points.collect { |point| "\e[35m#{point.to_s.ljust(5)}\e[0m" }.join(" | ")} |"
  end

  def bugs_total(bugs)
    puts "#{format_user("Total Bugs", length_username.length)} | #{bugs.collect { |bug| "\e[35m#{bug.to_s.ljust(5)}\e[0m" }.join(" | ")} |"
  end

  def chores_total(chores)
    puts "#{format_user("Total Chores", length_username.length)} | #{chores.collect { |chore| "\e[35m#{chore.to_s.ljust(5)}\e[0m" }.join(" | ")} |"
  end

end