require 'json'
require 'spec_helper'

describe Zenps::Payload do
  let(:subject) { Zenps::Payload.new }

  context 'Single input' do
    it 'returns an array of hashes from string input' do
      input = 'john.doe@acme.com'
      output = subject.get(input)
      expect(output.class).to eq Array
      expect(output.length).to eq 1
      expect(output[0][:email]).to eq 'john.doe@acme.com'
      expect(output[0][:locale]).to eq nil
    end

    it 'returns an array of hashes from json input' do
      input = { email: 'john.doe@acme.com' }
      output = subject.get(input)
      expect(output.class).to eq Array
      expect(output.length).to eq 1
      expect(output[0][:email]).to eq 'john.doe@acme.com'
      expect(output[0][:locale]).to eq nil
    end

    it 'returns an array of hashes from json input  with locale specified' do
      input = { email: 'john.doe@acme.com', locale: 'nl' }
      output = subject.get(input)
      expect(output.class).to eq Array
      expect(output.length).to eq 1
      expect(output[0][:email]).to eq 'john.doe@acme.com'
      expect(output[0][:locale]).to eq 'nl'
    end

    it 'returns an array of hashes from ruby object input ' do
      input = JSON.parse({ email: 'john.doe@acme.com' }.to_json, object_class: OpenStruct)
      output = subject.get(input)
      expect(output.class).to eq Array
      expect(output.length).to eq 1
      expect(output[0][:email]).to eq 'john.doe@acme.com'
      expect(output[0][:locale]).to eq nil
    end

    it 'returns an array of hashes from ruby object input with locale specified' do
      input = JSON.parse({ email: 'john.doe@acme.com', locale: 'nl' }.to_json, object_class: OpenStruct)
      output = subject.get(input)
      expect(output.class).to eq Array
      expect(output.length).to eq 1
      expect(output[0][:email]).to eq 'john.doe@acme.com'
      expect(output[0][:locale]).to eq 'nl'
    end
  end

  context 'Enumerator input' do
    it 'returns an array of emails from array of strings input' do
      input = ['john.doe.1@acme.com', 'john.doe.2@acme.com']
      output = subject.get(input)
      expect(output.class).to eq Array
      expect(output.length).to eq 2
      expect(output[0][:email]).to eq 'john.doe.1@acme.com'
      expect(output[0][:locale]).to eq nil
      expect(output[1][:email]).to eq 'john.doe.2@acme.com'
      expect(output[1][:locale]).to eq nil
    end

    it 'returns an array of emails from array of jsons input' do
      input = [{ email: 'john.doe.1@acme.com' }, { email: 'john.doe.2@acme.com' }]
      output = subject.get(input)
      expect(output.class).to eq Array
      expect(output.length).to eq 2
      expect(output[0][:email]).to eq 'john.doe.1@acme.com'
      expect(output[0][:locale]).to eq nil
      expect(output[1][:email]).to eq 'john.doe.2@acme.com'
      expect(output[1][:locale]).to eq nil
    end

    it 'returns an array of emails from array of jsons input' do
      input = [{ email: 'john.doe.1@acme.com', locale: 'nl' }, { email: 'john.doe.2@acme.com', locale: 'fr' }]
      output = subject.get(input)
      expect(output.class).to eq Array
      expect(output.length).to eq 2
      expect(output[0][:email]).to eq 'john.doe.1@acme.com'
      expect(output[0][:locale]).to eq 'nl'
      expect(output[1][:email]).to eq 'john.doe.2@acme.com'
      expect(output[1][:locale]).to eq 'fr'
    end

    it 'returns an array of emails from array of ruby objects input' do
      input = [
        JSON.parse({ email: 'john.doe.1@acme.com', locale: 'nl' }.to_json, object_class: OpenStruct),
        JSON.parse({ email: 'john.doe.2@acme.com', locale: 'fr' }.to_json, object_class: OpenStruct)
      ]
      output = subject.get(input)
      expect(output.class).to eq Array
      expect(output.length).to eq 2
      expect(output[0][:email]).to eq 'john.doe.1@acme.com'
      expect(output[0][:locale]).to eq 'nl'
      expect(output[1][:email]).to eq 'john.doe.2@acme.com'
      expect(output[1][:locale]).to eq 'fr'
    end
  end
end
