# Soap::Object

Module to make it simpler to tests SOAP web services.  The goal is
to abstract all information about how your call and parse results
from the web service within the soap objects.

## Defining

````ruby
class AirportService
  include SoapObject

  wsdl 'http://www.webservicex.net/airport.asmx?WSDL'

  def airport_name
    xpath('//Table/CityOrAirportName').first.content
  end

end
````

## Usage  

````ruby
require 'soap-object'

service = AirportService.new

service.operations
#=> [:get_airport_information_by_iso_country_code,
#    :get_airport_information_by_city_or_airport_name,
#    :get_airport_information_by_country,
#    :get_airport_information_by_airport_code]

service.get_airport_information_by_airport_code
#=> <Savon::Response>

````

By default soap-object attempts to handle any missing method call by passing it through to the underlying Savon client. This enable the  soap-object to handle calls to all operations on a given WSDL.  


## Using with Cucumber

Include the factory methods by placing the following line in the cucumber env.rb file.

````ruby
World(SoapObject::Factory)
````
By doing so, soap-object's methods are available in cucumbers step definitions.

````ruby
When(/^I request the airport information for "([^"]*)"$/) do |airport_code|
  using(AirportService).get_airport_information_by_airport_code({airport_code: airport_code})
end

Then(/^the airport name should be "([^"]*)"$/) do |airport_name|
  expect(using(AirportService).airport_name).to be eq(airport_name)
end
````

## Parsing the response

Several methods exists on the soap-object to help parse the response.

Return the xml response
   - to_xml

Return value at a specific path using xpath
  -  xpath(path)

Return the response as a Hash
  - to_hash

Return the body of the message as a Hash
  - body

Return the response as a Nokogiri document
  - doc

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
