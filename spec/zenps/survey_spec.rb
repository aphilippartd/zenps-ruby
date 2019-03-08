
require 'spec_helper'
describe Zenps::Survey do
  let(:subject) {Zenps::Survey}

  it 'performs request for mixed inputs' do
    expect_any_instance_of(Zenps::Client).to receive(:call).with(hash_including(email: 'john.doe.1@acme.com'))
    expect_any_instance_of(Zenps::Client).to receive(:call).with(hash_including(email: 'john.doe.2@acme.com', locale: 'nl'))
    expect_any_instance_of(Zenps::Client).to receive(:call).with(hash_including(email: 'john.doe.3@acme.com', locale: 'fr'))

    Zenps.configure(zenps_key: 'VALID_ZENPS_KEY')

    input = [
      'john.doe.1@acme.com',
      {email: 'john.doe.2@acme.com', locale: 'nl'},
      JSON.parse({email: 'john.doe.3@acme.com', locale: 'fr'}.to_json, object_class: OpenStruct)
    ]

    subject.call(input)
  end

  it 'performs request for with options' do

    body = {
      to: {
        email: 'john.doe.1@acme.com'
      },
      locale: 'nl',
      event: 'sign_up',
      tags: 'man, facebook'
    }.to_json

    expect_any_instance_of(Zenps::Client).to receive(:body).and_return(body)

    Zenps.configure(zenps_key: 'VALID_ZENPS_KEY')

    input = ['john.doe.1@acme.com']

    subject.call(input, locale: 'nl', event: 'sign_up', tags: ['man', 'facebook'])
  end
end
