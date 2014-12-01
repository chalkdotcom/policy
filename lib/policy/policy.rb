module Policy
  module Policy
    attr_reader :context, :message

    def self.included(base)
      base.class_eval { extend ClassMethods }
    end

    module ClassMethods
      def call(args = {})
        new(args).tap do |p|
          p.allowed
        end
      end

      def call!(args = {})
        new(args).tap do |p|
          result = p.allowed
          result = true if result.nil?
          raise PermissionError, p.message unless result
        end
      end
    end

    def initialize(args = {})
      @context = args

      @succeeded = true
    end

    def fail!(message = "")
      @message = message

      @succeeded = false
    end

    def succeed!
      @succeeded = true
    end

    def failed?
      !succeeded?
    end

    def succeeded?
      @succeeded
    end
  end
end