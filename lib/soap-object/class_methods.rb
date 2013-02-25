
module SoapObject
  module ClassMethods

    def wsdl(url)
      define_method(:with_wsdl) do 
        @wsdl ||= url
        {wsdl: @wsdl}
      end
    end

    def endpoint(value)
      define_method(:with_endpoint) do
        @endpoint ||= value
        {endpoint: @endpoint}
      end
    end

    def namespace(value)
      define_method(:with_namespace) do
        @namespace ||= value
        {namespace: @namespace}
      end
    end
  end
end
