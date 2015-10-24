class ZipCodeService
  include SoapObject

  wsdl 'http://www.webservicex.net/uszip.asmx?WSDL'
  log_level :error

  def get_zip_code_info(zip_code)
    get_info_by_zip 'USZip' => zip_code
  end

  def state
    message[:state]
  end

  def city
    message[:city]
  end

  def area_code
    message[:area_code]
  end

  private

  def message
    body[:get_info_by_zip_response][:get_info_by_zip_result][:new_data_set][:table]
  end
end
