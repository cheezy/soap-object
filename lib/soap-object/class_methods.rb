
module SoapObject
  module ClassMethods

    #
    # Sets the url for the wsdl.  It can be a path to a local file or
    # a url to a remote server containing the file.
    #
    # @param [String] either the local path to or the remote url to
    # the wsdl to use for all requests.
    #
    def wsdl(url)
      define_method(:with_wsdl) do 
        @wsdl ||= url
        {wsdl: @wsdl}
      end
    end

    #
    # Set a proxy server to be used.  This will be used for retrieving
    # the wsdl as well as making the remote requests.
    #
    # @param [String] the url for the proxy server
    #
    def proxy(url)
      define_method(:with_proxy) do
        {proxy: url}
      end
    end

    #
    # Sets the open timeout for retrieving the wsdl and making remote
    # requests.
    #
    # @param [Fixnum] the number of seconds for the timeout value
    #
    def open_timeout(timeout)
      define_method(:with_open_timeout) do
        {open_timeout: timeout}
      end
    end

    #
    # Sets the read timeout for retrieving the wsdl and reading the
    # results of remote requests.
    #
    # @param [Fixnum] the number of seconds for the timeout value
    #
    def read_timeout(timeout)
      define_method(:with_read_timeout) do
        {read_timeout: timeout}
      end
    end

    #
    # Add custom XML to the soap header.
    #
    # @param [Hash] will be converted into xml and placed in the soap
    # header
    #
    def soap_header(hsh)
      define_method(:with_soap_header) do
        {soap_header: hsh}
      end
    end

    #
    # Set the encoding for the message
    #
    # @param [String] the encoding to use
    #
    def encoding(enc)
      define_method(:with_encoding) do
        {encoding: enc}
      end
    end

    #
    # Use basic authentication for all requests
    #
    # @param [Array] username and password
    #
    def basic_auth(*name_password)
      define_method(:with_basic_auth) do
        {basic_auth: name_password}
      end
    end

    #
    # Use digest authentiation for all requests
    #
    # @param [Array] username and password
    #
    def digest_auth(*name_password)
      define_method(:with_digest_auth) do
        {digest_auth: name_password}
      end
    end

    #
    # Set the log level used for logging
    #
    # [Symbol] valid values are :info, :debug, :warn, :error, and :fatal
    #
    def log_level(level)
      define_method(:with_log_level) do
        {log: true, log_level: level, pretty_print_xml: true}
      end
    end

    def soap_version(version)
      define_method(:with_soap_version) do
        {soap_version: version}
      end
    end


    #
    # Enable/Disable SSL verification when calling services over HTTPS (Default is true)
    #
    # @param [Boolean] valid values are true, false
    #
    def ssl_verification(enable)
      if enable
        define_method(:with_ssl_verification) do
          {ssl_verify_mode: nil}
        end
      end
    end

    def ssl_version(version)
      define_method(:with_ssl_version) do
        {ssl_version: version}
      end
    end

  end
end
