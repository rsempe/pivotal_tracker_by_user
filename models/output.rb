class Output

  ### Attributes ###

  attr_accessor :length_username

  ### Instance Methods ###

  def initialize(length_username)
    @length_username = length_username
  end

  def number_of_iterations(iterations, dates)
    puts "\n\e[4;36m#{iterations.size} Iterations from #{dates.first.strftime("%m/%d/%y")} to #{dates.last.strftime("%m/%d/%y")}\e[0m"
  end

  def dates_of_iterations(dates)
    puts "\n#{format_user("Dates", length_username.length)} | #{dates.collect { |date| "\e[33m" + date.strftime("%m/%d").ljust(5) + "\e[0m"}.join(" | ")} |"
  end

  def iterations_for_user(user, points)
    puts "#{format_user(user, length_username.length)} | #{points.collect { |point| format_number(point.first, 5) }.join(" | ")} |"
  end

  def iterations_total(points)
    puts "#{format_user("Total Points", length_username.length)} | #{points.collect { |point| format_number(point, 5) }.join(" | ")} |"
  end

  def global_info(dates, features, bugs, chores)
    dates_of_iterations(dates)
    iterations_total(features)
    bugs_total(bugs)
    chores_total(chores)
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

  def bugs_total(bugs)
    puts "#{format_user("Total Bugs", length_username.length)} | #{bugs.collect { |bug| format_number(bug, 5) }.join(" | ")} |"
  end

  def chores_total(chores)
    puts "#{format_user("Total Chores", length_username.length)} | #{chores.collect { |bug| format_number(bug, 5) }.join(" | ")} |"
  end

end