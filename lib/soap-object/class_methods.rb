
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
  end
end
