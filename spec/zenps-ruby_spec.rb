require 'spec_helper'

describe Zenps do
  it 'sets configuration based on json input' do
    expect {
      Zenps.configure(zenps_key: 'VALID_ZENPS_KEY')
    }.to change { Zenps.config[:zenps_key] }.from(nil).to('VALID_ZENPS_KEY')
  end

  it 'sets configuration based on correct yml input' do
    expect {
      Zenps.configure_with(__dir__ + '/helpers/config.yml')
    }.to change { Zenps.config[:zenps_key] }.from(nil).to('VALID_ZENPS_KEY')
  end

  it 'fails when configuration file path does not exist' do
    expect {
      Zenps.configure_with(__dir__ + '/helpers/config_unexisting.yml')
    }.to raise_error(Zenps::ConfigurationPathError)
  end
end
