module ModularAuth
    class Error < StandardError; end

    class ConfigurationError < Error
        def initialize(message, context = {})
            @context = context
            super(message)
        end

        def to_s
            "#{super}: #{@context.inspect}"
        end
    end
    
    class InvalidConfigurationError < ConfigurationError; end
    class MissingConfigurationError < ConfigurationError; end

    class AuthenticationError < Error; end
    class InvalidCredentialsError < AuthenticationError; end
    class SessionExpiredError < AuthenticationError; end
end