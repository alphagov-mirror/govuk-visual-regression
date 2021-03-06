describe GovukVisualRegression::VisualDiff::WraithConfig do
  describe "config write and cleanup" do
    it "writes out a wraith config with the specified paths, and cleans up after" do
      wraith_config = described_class.new(paths: %w{foo bar }, review_domain: 'review')
      wraith_config.write

      expect(File.exist? wraith_config.location).to be true
      config_data = YAML.load_file wraith_config.location
      expect(config_data["paths"].values).to match_array %w{foo bar}

      wraith_config.delete
      expect(File.exist? wraith_config.location).to be false
    end

    it "ignores paths containing the word path" do
      wraith_config = described_class.new(paths: %w{/foo /foo/bar /some/path }, review_domain: 'review')
      wraith_config.write

      config_data = YAML.load_file wraith_config.location
      expect(config_data["paths"].values).to match_array %w{/foo /foo/bar}

      wraith_config.delete
      expect(File.exist? wraith_config.location).to be false
    end
  end
end
