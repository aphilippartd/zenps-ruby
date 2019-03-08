
require 'spec_helper'
describe Zenps::Client do
  let(:subject) {Zenps::Client.new}

  it 'raises KeyMissingError when zenps key has not been configured' do
    expect {
      subject.call(email: 'john.doe@acme.com')
    }.to raise_error(Zenps::KeyMissingError)
  end

  it 'fails when zenps key is invalid' do
    Zenps.configure(zenps_key: 'INVALID_ZENPS_KEY')
    response = subject.call(email: 'john.doe@acme.com')
    expect(response[:code]).to eq 401
  end

  it 'succeeds when zenps key is valid' do
    Zenps.configure(zenps_key: 'VALID_ZENPS_KEY')
    response = subject.call(email: 'john.doe@acme.com')
    expect(response[:code]).to eq 200
  end
end
