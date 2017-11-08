<!-- Outline for gem:
1. Check to see if there is an internet connection - If there isn't, let the user know and exit program

2. (If there is an internet connection) Greet user and have them sign in to github

3. Check users github and outoputs a numerical value to the commandline for the amount of repositories the user has

* Research a safe number for repository cloning - A number that wont crash the the average machine

4. If the user has more than 'X' repositories associated with their github, give the user options as to how many repsoitories they would like to download

* Perhaps give the user an option to download based on daterange or what have you.

5. Display progress bar? (Stretch goal)

5. Once cloning has come to an end, alert the user and exit

Necessary tools?
1. github Ruby API: https://github.com/octokit/octokit.rb

2.Check for interenet connectio https://stackoverflow.com/questions/2385186/check-if-internet-connection-exists-with-ruby -->




# Repo::Reco

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/repo/reco`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'repo-reco'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install repo-reco

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/<dwyn>/repo-reco. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Repo::Reco project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/<dwyn>/repo-reco/blob/master/CODE_OF_CONDUCT.md).
