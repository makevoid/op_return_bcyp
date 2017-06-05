# OpReturnBcyp

### op_return_bcyp

#### Gets the OP_RETURN data of a bitcoin transaction via the BlockCypher 3rd party api (via the blockcypher gem)


<!-- if you were looking for the bitcoin-core library then ... github.com/makevoid/op_return -->


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'op_return_bcyp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install op_return_bcyp

## Usage


```rb
TX = OpReturnBcyp::TX

# choose the bitcoin address you want to get the op-return "data protocol" data contents
address = "1Gj3S8GPgRQrP4gUCKVMFmMSdM6bMkB4wz"
transactions = TX.all address
p transactions

# subsequent requests are cached (you can configure redis or call set with a ttl to expire keys if you want to refresh the cache)
transactions = TX.all address
p transactions
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports (via Github Issues) and pull requests (obviously :D) are welcome: https://github.com/makevoid/op_return_bcyp.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
