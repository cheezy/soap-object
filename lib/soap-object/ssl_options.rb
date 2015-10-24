module SoapObject
  class SslOptions
    attr_accessor :verify_mode, :version

    def initialize
      yield self if block_given?
    end

    def options
      build_options
    end

    private

    def build_options
      options = {}
      options[:ssl_verify_mode] = verify_mode if verify_mode
      options[:ssl_version] = version if version
      options
    end
  end
end
