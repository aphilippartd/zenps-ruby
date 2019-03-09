require 'net/http'
require 'uri'
require 'json'

module Zenps
  # Api client for Zenps
  class Client
    def initialize
      check_configuration
    end

    def call(options = {})
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
      @response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request request }
    end

    def expose_response
      {
        email: get_attribute(:email),
        code: response.code.to_i,
        body: response.body
      }
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

    def body
      {
        to: to,
        locale: get_attribute(:locale, default: 'en'),
        event: get_attribute(:event),
        tags: tags
      }.compact.to_json
    end

    def to
      {
        email: get_attribute(:email),
        first_name: get_attribute(:first_name),
        last_name: get_attribute(:last_name)
      }.compact
    end

    def get_attribute(attribute, params = {})
      options[attribute.to_s] || options[attribute] || params[:default]
    end

    def tags
      get_attribute('tags', default: []).join(', ')
    rescue NoMethodError
      nil
    end

    def end_point
      'https://api.zenps.io/nps/v1/surveys'
    end
  end
end
