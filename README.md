[![Gem Version](https://badge.fury.io/rb/zenps-ruby.svg)](https://badge.fury.io/rb/zenps-ruby)
[![Codeship Status for aphilippartd/zenps-ruby](https://app.codeship.com/projects/beb50360-2413-0137-0f16-0e0a32caa97a/status?branch=master)](https://app.codeship.com/projects/330078)
[![Maintainability](https://api.codeclimate.com/v1/badges/065b707a3ccd884c40d6/maintainability)](https://codeclimate.com/github/aphilippartd/zenps-ruby/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/065b707a3ccd884c40d6/test_coverage)](https://codeclimate.com/github/aphilippartd/zenps-ruby/test_coverage)

# zenps-ruby

Wrapper for Zenps API

## Installation
```sh
gem install zenps-ruby
```

Or with bundler

```ruby
gem 'zenps-ruby'
```


## Configuration

This library needs to be configured with a Zenps Api key. Configuration can be performed as follows using a hash

```ruby
Zenps.configure(zenps_key: 'YOUR_ZENPS_KEY')
```

or with a yml configuration file

```ruby
Zenps.configure_with('path/to/your/configuration/file.yml')
```

## Usage

This wrapper allows you to send NPS surveys to your user in batch...

```ruby
Zenps::Survey.call([user_1, user_2], event: 'sign_up')
```

...or on a per-user basis

```ruby
Zenps::Survey.call(user, event: 'sign_up')
```

A user subject can either be:

  - A string (email of user to be surveyed)
  - A hash containing the following keys:
    - email (compulsory)
    - first_name (optional)
    - last_name (optional)
    - locale (optional --> defaults to `en` unless overwritten in general call)
  - An object that responds to
    - email method (compulsory)
    - first_name method (optional)
    - last_name method (optional)
    - locale (optional --> defaults to `en` unless overwritten in general call)

This allows for the gem to be used eg. in a rails application with User models that respond to the email method (and/or locale) as follows

```ruby
  Zenps::Survey.call(User.limit(10), event: 'sign_up')
```

but also in a more simple way as follows

```ruby
Zenps::Survey.call('john.doe@acme.com', event: 'sign_up')
```

The following options are available on the Survey call method:

| Options | Type            | Mandatory | Description                                     |
| --------|:---------------:| :--------:|------------------------------------------------:|
| locale  | String          | false     | Overwrites the user's AND default locale        |
| event   | String          | true      | Typically the event triggering the NPS survey   |
| tags    | Array\[String\] | false     | Tags giving you granularity in your analytics   |

Example:

```ruby
Zenps::Survey.call(user, locale: 'fr', event: 'sign_up', tags: ['man', 'facebook'])
```


## Contributing to zenps-ruby

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally. Coverage should remain as high as possible.
* Make sure all tests pass as well as rubocop checks.

## License

This gem is released under the [MIT License](http://www.opensource.org/licenses/MIT).
