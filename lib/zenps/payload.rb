module Zenps
  class Payload
    # Returns array of hashes from:
    #   - (array of) string(s)
    #   - (array of) hash(es)
    #   - (array of) object(s)
    def get(subjects)
      @subjects = subjects
      return payload
    end

    private

    attr_reader :subjects

    def payload
      @subjects = [subjects] unless array_but_not_hash?
      return get_payload
    end

    def get_payload
      return subjects.map do |subject|
        {
          email: get_email(subject),
          locale: get_locale(subject)
        }.compact
      end
    end

    def get_email(object)
      return object if object.class == String
      return object[:email] || object['email'] if object.class == Hash
      return object.email if object.respond_to? :email
    end

    def get_locale(object)
      return if object.class == String
      return object[:locale] || object['locale'] if object.class == Hash
      return object.locale if object.respond_to? :locale
    end

    def array_but_not_hash?
      subjects.respond_to?(:each) && !subjects.respond_to?(:keys)
    end
  end
end
