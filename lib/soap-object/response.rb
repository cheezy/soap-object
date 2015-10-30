module SoapObject
  module Response

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
  end
end
