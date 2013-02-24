require 'savon'
require 'soap-object/version'
require 'soap-object/class_methods'

module SoapObject
  attr_reader :wsdl

  def initialize
    @client = Savon.client(with_wsdl) if respond_to?(:with_wsdl)
  end

  def self.included(cls)
    cls.extend SoapObject::ClassMethods
  end

  def connected?
    not @client.nil?
  end
end
