require "yaml"
require "erb"

module ModularAuth
  class Configuration
    attr_accessor :secret_key, :session_timeout, :log_level, :modules

    def initialize
      @secret_key = nil
      @session_timeout = 3600
      @log_level = :info
      @modules = {}
    end

    # from yaml file
    def load_from_file(file_path)
      # possibility to use ruby "<%= %>" in the yaml file
      # -> (load): load_erb(yaml) -> load_yaml(erb)
      raise ArgumentError, "Configuration file not found: #{file_path}" unless File.exist?(file_path)

      erb_evaluated = ERB.new(File.read(file_path)).result
      yaml_hash = YAML.safe_load(
        erb_evaluated,
        permitted_classes: [Symbol],
        aliases: true
      ) || {}

      env_name = (ENV["MODULAR_AUTH_ENV"] || ENV["RACK_ENV"] || ENV["RAILS_ENV"] || "development").to_s
      defaults = yaml_hash["default"] || {}
      per_env = yaml_hash[env_name] || {}
      merged = deep_merge_hash(defaults, per_env)

      apply_hash!(merged)
      self
    end

    ## from environment variables
    def load_from_env
    end

    ## validate the configuration
    def validate!
    end

    private

    def deep_merge_hash(base_hash, override_hash)
      result = base_hash.dup
      override_hash.each do |key, value|
        result[key] = if result[key].is_a?(Hash) && value.is_a?(Hash)
                        deep_merge_hash(result[key], value)
                      else
                        value
                      end
      end
      result
    end

    def apply_hash!(hash)
      @secret_key = hash["secret_key"] unless hash["secret_key"].nil?
      @session_timeout = hash["session_timeout"] unless hash["session_timeout"].nil?
      @log_level = hash["log_level"].to_s.downcase.to_sym unless hash["log_level"].nil?
      @modules = hash["modules"] if hash.key?("modules") && hash["modules"].is_a?(Hash)
    end
  end
end
