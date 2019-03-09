module Zenps
  # Class for structuring subjects into array of hashes from:
  #   - (array of) string(s)
  #   - (array of) hash(es)
  #   - (array of) object(s)
  class Payload
    def get(subjects)
      @subjects = subjects
      payload
    end

    private

    attr_reader :subjects

    def payload
      @subjects = [subjects] unless array_but_not_hash?
      build_payload
    end

    def build_payload
      subjects.map do |subject|
        {
          email: get_email(subject),
          first_name: get_attribute(subject, 'first_name'),
          last_name: get_attribute(subject, 'last_name'),
          locale: get_attribute(subject, 'locale')
        }.compact
      end
    end

    def get_email(subject)
      subject.class == String ? subject : get_attribute(subject, 'email')
    end

    def get_attribute(subject, attribute)
      return if subject.class == String
      return subject[attribute] || subject[attribute.to_sym] if subject.class == Hash
      return subject.send(attribute) if subject.respond_to?(attribute)
    end

    def array_but_not_hash?
      subjects.respond_to?(:each) && !subjects.respond_to?(:keys)
    end
  end
end
