require 'savon'
require 'soap-object/version'
require 'soap-object/class_methods'

#
# module to make it simpler to tests SOAP web services.  You define
# the behavior by calling class methods to set the configuration.
#
module SoapObject
  attr_reader :wsdl

  def initialize
    @client = Savon.client(client_properties)
  end

  def self.included(cls)
    cls.extend SoapObject::ClassMethods
  end

  def connected?
    not @client.nil?
  end

  def operations
    @client.operations
  end

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
     :no_log].each do |sym|
      properties = properties.merge(self.send sym) if self.respond_to? sym
    end
    properties
  end

  def no_log
    {log: false}
  end

  private

  def body_for(method)
    @response.body["#{method.to_s}_response".to_sym]["#{method.to_s}_result".to_sym]
  end
end
