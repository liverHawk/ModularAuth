# frozen_string_literal: true

require_relative "modular_auth/version"

# Main module
module ModularAuth
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
  class Error < StandardError; end
  # Your code goes here...
end
