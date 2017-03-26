# RHTML

A Ruby Gem that allows you to generate an HTML string using a Ruby DSL generated via metaprogramming. 
Optimized for performance using define_method instead of method_missing?. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rhtml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rhtml

## Usage

```ruby
#
# Inline
#
Rhtml::Block.new do 
  h1 'Welcome to the RHTML Gem Example'
  p 'Using this DSL you can represent almost any HTML element.'
  p 'Use HTML attributes as well', class: 'sub-paragraph' 
  ul class: 'list' do
    li 'nested elements are also possible'
    li 'create as many as you like ' do
      a 'my hyperlink', href: 'http://github.com', target: '_blank'
    end
  end
end.out

# 
# OR Set to a Variable
#
block = Rhtml::Block.new do 
  p class: 'sub-paragraph' do 
    t 'my super awesome text without a tag'
  end
end

puts block.content

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/digitallyft/rhtml.

