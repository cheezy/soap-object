require 'savon'
require 'soap-object/version'
require 'soap-object/class_methods'
require 'soap-object/ssl_options'
require 'soap-object/factory'
require 'soap-object/response'

#
# module to make it simpler to tests SOAP web services.  The goal is
# to abstract all information about how your call and parse results
# from the web service within the soap objects.
#
# @example
# class ZipCodeService
#   include SoapObject
#
#   wsdl 'http://www.webservicex.net/uszip.asmx?WSDL'
#
#   def get_zipcode_info(zip_code)
#     get_info_by_zip 'USZip' => zip_code
#   end
#
#   def state
#     message[:state]
#   end
#
#   message
#     response.body[:get_info_by_zip_response][:get_info_by_zip_result][:new_data_set][:table]
#   end
# end
#
# There are many additional properties that can be set to configure
# the service calls.  See the comments for SoapObject::ClassMethods to
# view all of the options.
#
module SoapObject
  include Response

  attr_reader :wsdl, :response

  def initialize(platform)
    @client = platform.client(client_properties)
  end

  def self.included(cls)
    cls.extend SoapObject::ClassMethods
  end

  #
  # Returns true if the service has established communication with the
  # remote server.
  #
  def connected?
    not @client.nil?
  end

  #
  # Returns an array of operations that can be called on the remote
  # service.
  #
  def operations
    @client.operations
  end

  private
  DEFAULT_PROPERTIES = {log: false,
                         ssl_verify_mode: :none,
                         ssl_version: :SSLv3}

  def method_missing(operation, body)
    request = build_request(body)
    @response = @client.call(operation, request)
    response.to_xml
  end

  def build_request(body)
    type = body.is_a?(Hash) ? :message : :xml
    {type => body}
  end

  def client_properties
    properties = DEFAULT_PROPERTIES
     [:with_wsdl,
     :with_endpoint,
     :with_proxy,
     :with_open_timeout,
     :with_read_timeout,
     :with_soap_header,
     :with_encoding,
     :with_basic_auth,
     :with_digest_auth,
     :with_log_level,
     :with_soap_version,
     :with_ssl_options].each do |sym|
       properties = properties.merge(self.send sym) if self.respond_to? sym
    end
     properties
  end

end
