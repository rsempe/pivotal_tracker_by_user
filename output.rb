class Output

  ### Attributes ###

  attr_accessor :length_username

  ### Instance Methods ###

  def initialize(length_username)
    @length_username = length_username
  end

  def number_of_iterations(iterations)
    puts "\n\e[1;32m#{iterations.size} Iterations\e[0m"
  end

  def dates_of_iterations(dates)
    puts "\n#{"".ljust(length_username.length)} | #{dates.collect { |date| "\e[33m" + date.strftime("%m/%d").ljust(5) + "\e[0m"}.join(" | ")} |\n\n"
  end

  def iterations_for_user(user, points)
    puts "#{format_user(user, length_username.length)} | #{points.collect { |point| format_number(point.first, 5) }.join(" | ")} |"
  end

  def iterations_total(points)
    puts "\n#{format_user("Total", length_username.length)} | #{points.collect { |point| format_number(point, 5) }.join(" | ")} |\n\n"
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

end