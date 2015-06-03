require 'savon'
require 'cgi'
require 'soap-object/version'
require 'soap-object/class_methods'
require 'soap-object/factory'

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
  attr_reader :wsdl, :response

  def initialize
    @client = Savon.client(client_properties)
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

  #
  # Return the xml response
  #
  def to_xml
    response.to_xml
  end

  #
  # Return value at xpath
  #
  def xpath(path)
    response.xpath(path)
  end

  #
  # Return the response as a Hash
  #
  def to_hash
    response.hash
  end

  #
  # Return the body of the message as a Hash
  #
  def body
    response.body
  end

  #
  # Return the response as a Nokogiri document
  #
  def doc
    response.doc
  end

  private
  DEFAULT_PROPERTIES = {log: false,
                         ssl_verify_mode: :none,
                         ssl_version: :SSLv3}

  def method_missing(*args)
    operation =args.shift
    message = args.shift
    type = message.is_a?(String) ? :xml : :message
    call(operation, {type => message})
  end

  def call(operation, data)
    @response = @client.call(operation, data)
    response.to_xml
  end

  def client_properties
    properties = DEFAULT_PROPERTIES
     [:with_wsdl,
     :with_proxy,
     :with_open_timeout,
     :with_read_timeout,
     :with_soap_header,
     :with_encoding,
     :with_basic_auth,
     :with_digest_auth,
     :with_log_level,
     :with_soap_version,
     :with_ssl_verification,
     :with_ssl_version].each do |sym|
       properties = properties.merge(self.send sym) if self.respond_to? sym
    end
     properties
  end

end
