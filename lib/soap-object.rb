require 'savon'
require 'soap-object/version'
require 'soap-object/class_methods'

#
# module to make it simpler to tests SOAP web services.  The goal is
# to abstract all information about how your call and parse results
# from the web service within the soap objects.
#
# @example
# class AirportService
#   include SoapObject
#
#   wsdl 'http://www.webservicex.net/airport.asmx?WSDL'
#
#   def get_airport_name_for(airport_code)
#     response = get_airport_information_by_airport_code airport_code: airport_code
#     doc = Nokogiri::XML(response)
#     doc.xpath('//Table/CityOrAirportName').first.content
#   end
# end
#
# There are many additional properties that can be set to configure
# the service calls.  See the comments for SoapObject::ClassMethods to
# view all of the options.
#
module SoapObject
  attr_reader :wsdl

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

  def no_log
    {log: false}
  end

  private

  def method_missing(*args)
    method = args.shift
    @response = @client.call(method, {message: args.first})
    body_for(method)
  end

  def client_properties
    properties = {}
    [:with_wsdl,
     :with_proxy,
     :with_open_timeout,
     :with_read_timeout,
     :with_soap_header,
     :with_encoding,
     :with_basic_auth,
     :no_log].each do |sym|
      properties = properties.merge(self.send sym) if self.respond_to? sym
    end
    properties
  end

  def body_for(method)
    @response.body["#{method.to_s}_response".to_sym]["#{method.to_s}_result".to_sym]
  end
end
