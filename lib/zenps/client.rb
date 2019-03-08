require 'net/http'
require 'uri'
require 'json'

module Zenps
  class Client

    def initialize
      check_configuration
    end

    def call(options={})
      @options = options
      perform_request
      expose_response
    end

    private

    attr_reader :options, :response

    def check_configuration
      raise KeyMissingError if ::Zenps.config[:zenps_key].nil?
    end

    def perform_request
      request = Net::HTTP::Post.new(uri, header)
      request.body = body
      @response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) {|http| http.request request}
    end

    def expose_response
      {
        email: email,
        code: response.code.to_i,
        body: response.body
      }
    end

    def body
      {
        to: {
          email: email,
        },
        locale: locale,
        event: event,
        tags: tags
      }.compact.to_json
    end

    def uri
      @uri ||= URI.parse(end_point)
    end

    def header
      @header ||= {
        'Content-Type': 'text/json',
        'Authorization': ::Zenps.config[:zenps_key]
      }
    end

    def email
      options[:email]
    end

    def locale
      options['locale'] || options[:locale] || 'en'
    end

    def event
      options['event'] || options[:event]
    end

    def tags
      (options['tags'] || options[:tags] || []).join(', ')
    rescue NoMethodError
    end

    def end_point
      'https://api.zenps.io/nps/v1/surveys'
    end
  end
end
