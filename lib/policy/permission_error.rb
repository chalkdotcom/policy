module Policy
  class PermissionError < StandardError
    attr_reader :message

    def initialize(message = nil)
      @message = message
    end
  end
end