
module SoapObject
  module ClassMethods

    def wsdl(url)
      define_method(:with_wsdl) do 
        @wsdl ||= url
        {wsdl: @wsdl}
      end
    end

    def proxy(url)
      define_method(:with_proxy) do
        @proxy ||= url
        {proxy: @proxy}
      end
    end

    def open_timeout(timeout)
      define_method(:with_open_timeout) do
        @open_timeout ||= timeout
        {open_timeout: @open_timeout}
      end
    end

    def read_timeout(timeout)
      define_method(:with_read_timeout) do
        @read_timeout ||= timeout
        {read_timeout: @read_timeout}
      end
    end
  end
end
