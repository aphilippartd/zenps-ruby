module Zenps
  class Survey
    # Takes list of subjects and sends NPS survey to all subjects
    def self.call(subjects, options={})
      new.call(subjects, options)
    end

    def call(subjects, options={})
      @subjects = subjects
      @options = options
      perform_requests
    end

    private

    attr_reader :subjects, :options

    def perform_requests
      payload_getter.get(subjects).map do |payload|
        api_client.call(payload.merge(options))
      end
    end

    def payload_getter
      @payload_getter ||= Payload.new
    end

    def api_client
      @api_client ||= Client.new
    end
  end
end
