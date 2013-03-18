
module SoapObject
  module Factory

    def using(cls, &block)
      @the_service = find_service(cls)
      block.call @the_service if block
      @the_service
    end

    private

    def find_service(cls)
      services[cls] = cls.new unless services[cls]
      services[cls]
    end

    def services
      @services ||= {}
    end
  end
end
