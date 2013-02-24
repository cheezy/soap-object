
module SoapObject
  module ClassMethods

    def wsdl(url)
      define_method(:with_wsdl) do 
        @wsdl ||= url
        {wsdl: @wsdl}
      end
    end
  end
end
