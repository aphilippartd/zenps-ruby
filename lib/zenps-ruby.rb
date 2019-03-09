require 'yaml'
require 'logger'
require_relative 'zenps/client.rb'
require_relative 'zenps/payload.rb'
require_relative 'zenps/survey.rb'
# Zenps ruby wrapper
module Zenps
  # Configuration defaults
  @config = {
    zenps_key: nil
  }

  @valid_config_keys = @config.keys

  @logger = Logger.new(STDOUT)

  # Configure through hash
  def self.configure(options = {})
    options.each { |k, v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym }
  end

  # Configure through yaml file
  def self.configure_with(path_to_yaml_file)
    begin
      config = YAML.safe_load(IO.read(path_to_yaml_file))
    rescue Errno::ENOENT
      raise ConfigurationPathError
    end
    configure(config)
  end

  def self.config
    @config
  end

  # Missing ZENPS key error
  class KeyMissingError < StandardError
    def initialize(msg = 'Zenps configuration key missing')
      super
    end
  end

  # Wrong configuration path error
  class ConfigurationPathError < StandardError
    def initialize(msg = "YAML configuration file couldn't be found.")
      super
    end
  end
end
