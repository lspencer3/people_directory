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
     	@result = response ["data"]
      #puts @result
      #render plain: @result.inspect
    	#return @result
  	end 

  def count_letters

    response = HTTParty.get(url, headers: headers)
    raise StandardError.new(response.parsed_response) unless response.success?
    result = response ["data"]

    emailstring = ""

    alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p","q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

    frequencyarr = []

    result.each do |person|

    #puts "current email address is: #{person["email_address"]} " 

    emailstring += "#{person["email_address"]}"

    end

    puts "this is the email array #{emailstring}"


    alphabet.each do |letter|
      #puts "#{letter}: " + emailstring.count(letter).to_s

      addhash = {"#{letter}" => emailstring.count("#{letter}")}

      frequencyarr.push(addhash)

    end 

    puts frequencyarr 

  end

end


#testing running ruby script alone
#peoples = Base_controller.new()

#@newdata = JSON.pretty_generate(peoples.process_records)

#puts newdata




