require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
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

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    render("geocoding/street_to_coords.html.erb")

  end

end
