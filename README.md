[![Codeship Status for aphilippartd/zenps-ruby](https://app.codeship.com/projects/beb50360-2413-0137-0f16-0e0a32caa97a/status?branch=master)](https://app.codeship.com/projects/330078)

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
Zenps::Survey.call([user_1, user_2])
```

...or on a per-user basis

```ruby
Zenps::Survey.call(user)
```

A user subject can either be:

  - A string (email of user to be surveyed)
  - A hash containing the following keys:
    - email (compulsory)
    - locale (optional --> defaults to `en`)
  - An object that responds to
    - email method (compulsory)
    - locale (optional --> defaults to `en`)

This allows for the gem to be used eg. in a rails application with User models that respond to the email method (and/or locale) as follows

```ruby
  Zenps::Survey.call(User.limit(10))
```

but also in a more simple way as follows

```ruby
Zenps::Survey.call('john.doe@acme.com')
```

The following options are available on the Survey call method:

  - locale (String) - Overwrites the user's AND default locale
  - event (String) - Typically the event triggering the NPS survey
  - tags (Array) - Tags giving you granularity in your analytics

Example:

```ruby
Zenps::Survey.call(user, locale: 'fr', event: 'sign_up', tags: ['man', 'facebook'])
```


## Contributing to pipedrive-ruby

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## License

This gem is released under the [MIT License](http://www.opensource.org/licenses/MIT).
