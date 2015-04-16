# Git::Changelog

`git-changelog` creates a Markdown formatted changelog file out of
your git logs.

## Installation

Add this line to your application's Gemfile:

    gem 'git-changelog'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git-changelog

## Usage

Simply call `git-changelog` within your git project, it will write
your changelog to stdout.

## Assumptions

* All tags that should show up in the changelog must be in Gem::Version format
* Use develop / master branch model with no release branches
* The very first commit is an empty commit that belongs to both master
  and develop

## Contributing

1. Fork it ( https://github.com/velaluqa/git-changelog/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
