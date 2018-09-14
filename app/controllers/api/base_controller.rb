require "rubygems"
require "bundler/setup"
Bundler.require
require "active_support/all"
require "json"



class Base_controller 

	def initialize
	end

	def url
		"https://api.salesloft.com/v2/people.json"
	end

     def headers
         {
      		"Authorization" => "Bearer #{ENV.fetch("SLAPIKEY")}"
    		}
     end

	def process_records(&block)
    		response = HTTParty.get(url, headers: headers)
     	raise StandardError.new(response.parsed_response) unless response.success?
     	result = JSON.parse(response.body)
    		return result
  	end 
end

peoples = Base_controller.new()

puts JSON.pretty_generate(peoples.process_records)
