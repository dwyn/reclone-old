class Reclone::CLI
  def call
    exit unless up?
    log_in
	end

  def up?
    Net::Ping::External.new("www.google.com").ping?
  end

  def  log_in
    puts "Hello user"; sleep 1
    puts "Please enter your user name."
    username = gets.strip

    puts "Awesome. Please enter your password."
    user_password = gets.strip

    client = Octokit::Client.new(:login => username, :password => user_password )
    # Fetch the current user
    client.user
    binding.pry
  end

end







  # def main_menu
  #   puts "Hello user"
  #   log_in
  # end