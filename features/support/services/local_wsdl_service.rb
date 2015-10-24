class LocalWsdlService
  include SoapObject

  wsdl "#{File.dirname(__FILE__)}/../wsdl/uszip.asmx.wsdl"
end
