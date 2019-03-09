require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start

require 'zenps-ruby'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    Zenps.configure(zenps_key: nil)

    zenps_url_regex = %r{api.zenps.io\/nps\/v1\/surveys}

    stub_request(:post, zenps_url_regex)
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby', 'Authorization' => 'INVALID_ZENPS_KEY' })
      .to_return(status: 401, body: { success: false }.to_json, headers: {})

    stub_request(:post, zenps_url_regex)
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby', 'Authorization' => 'VALID_ZENPS_KEY' })
      .to_return(status: 200, body: { success: true }.to_json, headers: {})
  end
end
