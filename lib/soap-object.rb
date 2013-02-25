require 'savon'
require 'soap-object/version'
require 'soap-object/class_methods'

module SoapObject
  attr_reader :wsdl

  def initialize
    @client = Savon.client(with_wsdl.merge(no_log)) if wsdl?
    @client = Savon.client(with_endpoint.merge(with_namespace).merge(no_log)) if endpoint?
  end

  def self.included(cls)
    cls.extend SoapObject::ClassMethods
  end

  def connected?
    not @client.nil?
  end

  def operations
    @client.operations if wsdl?
  end

  def method_missing(*args)
    method = args.shift
    @response = @client.call(method, {message: args.first})
    body_for(method)
  end

  private

  def body_for(method)
    @response.body["#{method.to_s}_response".to_sym]["#{method.to_s}_result".to_sym]
  end
  
  def wsdl?
    respond_to? :with_wsdl
  end

  def endpoint?
    respond_to? :with_endpoint and respond_to? :with_namespace
  end

  def no_log
    {log: false}
  end
end
