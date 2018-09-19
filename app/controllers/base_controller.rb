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
     	return @result = response ["data"]
        #puts @result
        #render plain: @result.inspect
    	#return @result
  	end 

    def count_letters

        process_records()

        #response = HTTParty.get(url, headers: headers)
        #raise StandardError.new(response.parsed_response) unless response.success?
        #result = response ["data"]

        longemailstring = ""

        alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p","q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

        frequencyhash = {}

        @result.each do |person|

            #puts "current email address is: #{person["email_address"]} " 

            longemailstring += "#{person["email_address"]}"
        end

        #puts "this is the email array #{longemailstring}"


        alphabet.each do |letter|

            #puts "#{letter}: " + longemailstring.count(letter).to_s

            currenthash = {"#{letter}" => longemailstring.count(letter)}

            frequencyhash = frequencyhash.merge!(currenthash)

            #puts "hash: #{frequencyhash}" 
        end 

        #puts frequencyhash 

        @sortedhash = frequencyhash.sort_by {|_key, value| value}.reverse

        #puts @sortedhash
    end

    def find_possible_dups

        process_records()

        pdata = @results

        puts "hello #{pdata}"

        #x = 0

        #while x <19

            #curname = @results[x].first_name

            #puts curname

            #x+= 1
            #break if x > 10 #@results.length
        #end    
    end     

end


#testing running ruby script alone
#peoples = Base_controller.new()

#@newdata = JSON.pretty_generate(peoples.process_records)

#puts newdata




