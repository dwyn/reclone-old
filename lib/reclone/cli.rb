require 'dotenv/load'

class Reclone::CLI
  @current_user = ""
  @current_user_repositories = []
  @clone_directory = ""

  def call
    up?
    get_config

    # log_in
    recloner   
	end


  def get_config
    Octokit.configure do |c|
      c.login = ENV['GIT_USER']
      c.password = ENV['GIT_PASSWORD']
    end
    @current_user = Octokit.user
  end

  def up?
    if Net::Ping::External.new("www.google.com").ping? != true
      puts "You need an internet connection to run this program..."
      puts "As if I needed to tell you that."; sleep 1
      puts "Good bye for now, human."
      exit
    end
  end

  def directory_exists?(directory)
    Dir.exists?(directory)
  end

  def log_in
    #https://goo.gl/UXLeNL
    # YAML.load(File.open(File.join(File.dirname(__FILE__), 'data.yaml')))
    # puts "Hello user"; sleep 1
    # puts "Please enter your user name."
    # username = gets.strip

    # puts "Awesome. Please enter your password."
    # user_password = gets.strip
    # # DO SOMETHING ABOUT BAD CREDENTIALS!!!
    # puts "Great. Now what directory would you like to clone to?"
    # puts "For example: /Users/user_name/user_repo_folder/"
    # @clone_directory = gets.strip

    # client = Octokit::Client.new(login: "ENV['GIT_USER']", oauth_token: "ENV['GIT_PASSWORD']" )
    # repos = client.repositories("frxnklin", {sort: :pushed_at})

    # @current_user = client.user
    # @current_user_repositories = repos
  end

# #repositories(user = nil, options = {}) ⇒ Array<Sawyer::Resource>
# Also known as: list_repositories, list_repos, repos
# system "sudo apt-get -y install vim"

# if $?.exitstatus > 0
#   puts "I failed to install Vim, I am very sorry :'(" 
# end
# Executes cmd in a subshell, returning true if the command was found and ran successfully, false otherwise. An error status is available in $?. The arguments are processed in the same way as for Kernel::exec.
  
  def with_pagination
    pagination_setting = self.auto_paginate 
    self.auto_paginate = true
    yield
  ensure
    self.auto_paginate = pagination_setting
  end

  def recloner
    # ratelimit           = Octokit.ratelimit
    # ratelimit_remaining = Octokit.rate_limit.remaining
    # puts "Rate Limit Remaining: #{ratelimit_remaining} / #{ratelimit}"
    # puts
    array = []
    
    temp_directory = ""
    # Octokit.client.repos({}, query: {type: 'owner'}).each do |repository|

      
      Octokit.client.all_repositories(auto_traversal: false).each do |repository|
      array << repository
      binding.pry
      exit
      temp_directory = "/Users/dwyn/Development/code/#{repository.name}"
      if directory_exists?(temp_directory)
        puts "The directory #{temp_directory} already exists"
        puts "...moving on"
        puts " "
      else
        puts "#{repository.name} Cloned!" if exec("git clone #{repository.uri}")
      end 
      full_name = repository[:full_name]
      has_push_access = repository[:permissions][:push]
    
      access_type = if has_push_access
          "write"
        else
          "read-only"
        end

      puts "User has #{access_type} access to #{full_name}."
    end
    
    puts "good bye"

  end

end




#######################
# require 'octokit'

# ratelimit           = Octokit.ratelimit
# ratelimit_remaining = Octokit.ratelimit_remaining
# puts "Rate Limit Remaining: #{ratelimit_remaining} / #{ratelimit}"
# puts

# repos = Octokit.repositories("komasaru", {sort: :pushed_at})
# # ==== OAuth 認証の場合
# #cl = Octokit::Client.new(login: "komasaru", oauth_token: "token_string")
# #repos = cl.repositories("komasaru", {sort: :pushed_at})

# # 値取得
# repos.each do |repo|
#   puts "[ #{repo.name} ]"
#   puts "\tOwner       : #{repo.owner.login}"
#   puts "\tFull Name   : #{repo.full_name}"
#   puts "\tDescription : #{repo.description}"
#   puts "\tPrivate     : #{repo.private}"
#   puts "\tLanguage    : #{repo.language}"
#   puts "\tURL         : #{repo.html_url}"
#   puts "\tCreated at  : #{repo.created_at}"
#   puts "\tUpdated at  : #{repo.updated_at}"
#   puts "\tPushed  at  : #{repo.pushed_at}"
#   puts
# end


# def clone(repository, name, opts = {})
# @path = opts[:path] || '.'
# clone_dir = opts[:path] ? File.join(@path, name) : name

# arr_opts = []
# arr_opts << "--bare" if opts[:bare]
# arr_opts << "-o" << opts[:remote] if opts[:remote]
# arr_opts << "--depth" << opts[:depth].to_i if opts[:depth] && opts[:depth].to_i > 0

# arr_opts << '--'
# arr_opts << repository
# arr_opts << clone_dir

# command('clone', arr_opts)

# opts[:bare] ? {:repository => clone_dir} : {:working_directory => clone_dir}
# end