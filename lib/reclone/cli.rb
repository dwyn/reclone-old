class Reclone::CLI
  @current_user = ""
  @current_user_repositories = []
  @clone_directory = ""

  def call
    exit unless up?
    log_in
    recloner   

    secret = YAML.load_file(config)
    creditials = get_config(secret)
    Octokit.auto_paginate = false
	end


  def get_config(config_hash)
    config = {
      :access_token => config_hash['ACCESS_TOKEN'],
      :client_secret => config_hash['CLIENT_SECRET']
    }
  end

  def up?
    Net::Ping::External.new("www.google.com").ping?
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

    client = Octokit::Client.new(login: "frxnklin", oauth_token: "dwyn1234!" )
    repos = client.repositories("frxnklin", {sort: :pushed_at})
    binding.pry
    @current_user = client.user
    @current_user_repositories = repos
  end

# #repositories(user = nil, options = {}) ⇒ Array<Sawyer::Resource>
# Also known as: list_repositories, list_repos, repos
# system "sudo apt-get -y install vim"

# if $?.exitstatus > 0
#   puts "I failed to install Vim, I am very sorry :'(" 
# end
# Executes cmd in a subshell, returning true if the command was found and ran successfully, false otherwise. An error status is available in $?. The arguments are processed in the same way as for Kernel::exec.
  
  def recloner
    # ratelimit           = Octokit.ratelimit
    # ratelimit_remaining = Octokit.rate_limit.remaining
    # puts "Rate Limit Remaining: #{ratelimit_remaining} / #{ratelimit}"
    # puts

    temp_directory = ""

    @current_user.all_repositories.each do |repository|

      temp_directory = "/Users/dwyn/Development/code/#{repository.name}"
      if directory_exists?(temp_directory)
        puts "The directory #{temp_directory} already exists"
        puts "...moving on"
        puts " "
        binding.pry
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

        # binding.pry

      puts "User has #{access_type} access to #{full_name}."
    end
    
    puts "good bye"

  end

end




########################
# You don't ever want to commit code with passwords or access tokens (any sensitive data). Typically you grab credentials from environment variables or because this is ruby you could make a yaml file and load your credentials that way. Something like...

# require 'yaml'
# require 'spotify-client'

# class Beats
#   def initialize(config)
#     secret = YAML.load_file(config)
#     creditials = get_config(secret)
#     @spotify = Spotify::Client.new(creditials)
#     ids = track_ids(get_user_playlist)
#     get_song_attributes(ids)
#   end

#   def get_config(config_hash)
#     config = {
#       :access_token => config_hash['ACCESS_TOKEN'],
#       :client_secret => config_hash['CLIENT_SECRET']
#     }
#   end

#   ...
# end
# Where your yaml file would look like:

# ACCESS_TOKEN: 'my-access-token'
# CLIENT_SECRET: 'my-client-secret'

##########################
# require 'octokit'

# # API 呼び出し回数
# ratelimit           = Octokit.ratelimit
# ratelimit_remaining = Octokit.ratelimit_remaining
# puts "Rate Limit Remaining: #{ratelimit_remaining} / #{ratelimit}"
# puts

# # インスタンス化
# # ==== 認証無しの場合
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