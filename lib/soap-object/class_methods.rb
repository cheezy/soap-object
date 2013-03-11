
module SoapObject
  module ClassMethods

    #
    # Sets the url for the wsdl.  It can be a path to a local file or
    # a url to a remote server containing the file.
    #
    # @param [Stroing] either the local path to or the remote url to
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
        @proxy ||= url
        {proxy: @proxy}
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
        @open_timeout ||= timeout
        {open_timeout: @open_timeout}
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
        @read_timeout ||= timeout
        {read_timeout: @read_timeout}
      end
    end
  end
end
