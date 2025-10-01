# frozen_string_literal: true

RSpec.describe ModularAuth::Configuration do
  describe "#load_from_file" do
    it "should load the configuration from the file" do
      config = ModularAuth::Configuration.new
      config.load_from_file("config/modular_auth.yaml")
      expect(config.session_timeout).to eq(3600)
    end
  end

  describe "#validate!" do
    it "missing configuration should raise an error" do
      config = ModularAuth::Configuration.new
      config.secret_key = nil
      expect { config.validate! }.to raise_error(ModularAuth::MissingConfigurationError)
    end
  end
end
