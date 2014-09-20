require 'yaml'
require 'deep_merge/core'

class ConfigBuilder::Loader::YAML

  # Load configuration from YAML files in one or more directories
  #
  # @overload yamldir(path)
  #   @param path [String] A directory path containing YAML files
  # @overload yamldir(paths)
  #   @param paths [Array<String>] A list of directory paths containing YAML files
  #
  # @return [Hash]
  def yamldir(input)
    dirs = Array(input)

    files = dirs.map do |dir|
      pattern = File.join(dir, '*.{yml,yaml}')
      Dir.glob(pattern)
    end.flatten

    rv = {}

    files.each do |file|
      contents = yamlfile(file)
      if contents.is_a? Hash
        rv = DeepMerge::deep_merge!(contents, rv, {:preserve_unmergables => false})
      end
    end

    rv
  end

  # Load configuration from a file
  #
  # @param file_path [String]
  #
  # @return [Hash]
  def yamlfile(file_path)
    ::YAML.load_file(file_path)
  end

  ConfigBuilder::Loader.register(:yaml, self)
end
