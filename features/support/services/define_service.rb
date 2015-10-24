class DefineService
  include SoapObject

  wsdl "http://services.aonaware.com/DictService/DictService.asmx?WSDL"

  def definition_for(word)
    define word: word
  end
end
