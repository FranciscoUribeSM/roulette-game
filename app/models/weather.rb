class Weather < ApplicationRecord

    require "openssl"
    require 'net/http'
    require 'json'

    # Connection with WeatherUnclock API
    def self.get_forecast
        # Get the dates today and tomorrow to make the request
        date_today= Time.now.in_time_zone('Santiago').to_date
        date_tomorrow = (date_today +1).strftime("%Y.%m.%d")
        date_today = date_today.strftime("%Y.%m.%d")
        
        # uri = URI("http://api.weatherunlocked.com/api/trigger/-33.4372,-70.6506/forecast%20#{date_today},#{date_tomorrow}%20temperature%20gt%2016%20include7dayforecast?app_id=bc1e7fc1&app_key=68745966c16df3e92a7a09d1b861ce4c")
        uri = URI("http://api.apixu.com/v1/forecast.json?key=cb33b4318dda4467924194800181911&q=Santiago&days=8&dt=2018-11-23")
        res = Net::HTTP.get_response(uri)
        weather = res.body if res.is_a?(Net::HTTPSuccess)
        weather =JSON.parse(weather).with_indifferent_access
        # temp = weather[:ForecastWeather][:Days][6][:temp_max_c].to_f

        temp = weather[:forecast][:forecastday][6][:day][:maxtemp_c].to_f
        Weather.create(temp: temp)

        temp.to_i
    end

    #check if you have the forecast
    def self.forecast_weather

        date_today= Time.now.in_time_zone('Santiago').to_date.strftime("%Y.%m.%d")
        weather = Weather.last

        if Weather.last == 'nil'
            if (weather.created_at.strftime("%Y.%m.%d") == date_today) 
                return weather.temp.to_i
            end
        else 
            return get_forecast
        end
            
    end
    
end
