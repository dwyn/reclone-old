require 'pathname'

class Reclone::CLI
  def call
    exit unless up?
    log_in
	end

  def up?
    Net::Ping::External.new("www.google.com").ping?
  end

  def file_dir_or_symlink_exists?(path_to_file)
    File.exist?(path_to_file) || File.symlink?(path_to_file)
  end

  def  log_in
    puts "Hello user"; sleep 1
    puts "Please enter your user name."
    username = gets.strip

    puts "Awesome. Please enter your password."
    user_password = gets.strip

    client = Octokit::Client.new(:login => username, :password => user_password )

    Octokit.auto_paginate = true
    test = []
    temp_directory = ""

    client.repositories.each do |repository|
      
      temp_directory = Dir.pwd + repository.name

      if file_dir_or_symlink_exists?(temp_directory)
        puts "The directory #{temp_directory} already exists"
        puts "...moving on"
        puts " "
      else 
        git clone repository.html_url
      end 
      full_name = repository[:full_name]
      has_push_access = repository[:permissions][:push]
    
      access_type = if has_push_access
          "write"
        else
          "read-only"
        end
        binding.pry

      puts "User has #{access_type} access to #{full_name}."
    end







    puts "good bye"

  end

end







  # def main_menu
  #   puts "Hello user"
  #   log_in
  # end