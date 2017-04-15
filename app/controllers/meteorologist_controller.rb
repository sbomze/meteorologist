require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    street_address_array = @street_address.split
    base_url = "http://maps.googleapis.com/maps/api/geocode/json?address="
    address_url = ""

    street_address_array.each do |address|
      address_url = address_url + address + "+"
    end

    final_url_1 = base_url + address_url[0...-1]

    parsed_data = JSON.parse(open(final_url_1).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    final_url_2 = "https://api.darksky.net/forecast/9cc5d2e00c5a69d0cfe8871170d8d3be/" + latitude.to_s + "," + longitude.to_s
    parsed_data = JSON.parse(open(final_url_2).read)

    @current_temperature = current_temp = parsed_data["currently"]["temperature"]

    @current_summary = current_temp = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = current_temp = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = current_temp = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = current_temp = parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
