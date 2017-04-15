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

    address_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address}"
    parsed_address_data = JSON.parse(open(address_url).read)

    @latitude = parsed_address_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_address_data["results"][0]["geometry"]["location"]["lng"]

    weather_url = "https://api.darksky.net/forecast/c571184fa36ca34b14a427a51fe63b73/#{@latitude},#{@longitude}"
    parsed_weather_data = JSON.parse(open(weather_url).read)

    @current_temperature = parsed_weather_data["currently"]["temperature"]

    @current_summary = parsed_weather_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_weather_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_weather_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_weather_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
