# Soap::Object

Module to make it simpler to tests SOAP web services.  The goal is
to abstract all information about how your call and parse results
from the web service within the soap objects.

````ruby
class AirportService
  include SoapObject

  wsdl 'http://www.webservicex.net/airport.asmx?WSDL'

  def get_airport_name_for(airport_code)
    response = get_airport_information_by_airport_code airport_code: airport_code
    doc = Nokogiri::XML(response)
    doc.xpath('//Table/CityOrAirportName').first.content
  end
end
````

## Installation

Add this line to your application's Gemfile:

    gem 'soap-object'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install soap-object


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
