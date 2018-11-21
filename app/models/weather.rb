class Weather < ApplicationRecord

    require "openssl"
    require 'net/http'
    require 'json'

    # Connection with WeatherUnclock API
    def self.get_forecast
        # Get the date to make the request
        date_today= Time.now.in_time_zone('Santiago').to_date
        date = (date_today +7).strftime("%Y-%m-%d")
        
        uri = URI("http://api.worldweatheronline.com/premium/v1/weather.ashx?q=Santiago&key=3a21433208bb459b83b140805182111&num_of_days=1&date=#{date}&format=json")
        res = Net::HTTP.get_response(uri)
        weather = res.body if res.is_a?(Net::HTTPSuccess)
        weather =JSON.parse(weather).with_indifferent_access

        temp = weather[:data][:weather][0][:maxtempC].to_f
        Weather.create(temp: temp)

        temp.to_i
    end

    #check if you have the forecast
    def self.forecast_weather

        date_today= Time.now.in_time_zone('Santiago').to_date.strftime("%Y.%m.%d")
        weather = Weather.last
        puts weather
        #cheked that there are records
        if weather

            #check if you already have that data
            if (weather.created_at.strftime("%Y.%m.%d") == date_today)               
                return weather.temp.to_i  
            else   
                return get_forecast
            end

        else    
            return get_forecast
        end
            
    end
    
end
