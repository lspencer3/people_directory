require "rubygems"
require "bundler/setup"
Bundler.require
require "active_support/all"
require "json"



class BaseController < ApplicationController

	def initialize
	
    	def url
    		"https://api.salesloft.com/v2/people.json"
    	end

        def headers
            {
          		"Authorization" => "Bearer #{ENV.fetch("SLAPIKEY")}"
        	}
        end

    end

	def process_records
    	response = HTTParty.get(url, headers: headers)
     	raise StandardError.new(response.parsed_response) unless response.success?
     	result = JSON.pretty_generate(response ["data"])
      puts result
      render plain: result.inspect
    	#return @result
  	end 
end

#peoples = Base_controller.new()

#@newdata = JSON.pretty_generate(peoples.process_records)

#puts newdata




