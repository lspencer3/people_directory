require "rubygems"
require "bundler/setup"
Bundler.require
require "active_support/all"
require "json"



class BaseController < ApplicationController
	
    	def url
    		"https://api.salesloft.com/v2/people.json"
    	end

        def headers
            {
          		"Authorization" => "Bearer #{ENV.fetch("SLAPIKEY")}"
        	}
        end

	def process_records
    	response = HTTParty.get(url, headers: headers)
     	raise StandardError.new(response.parsed_response) unless response.success?
     	return @result = response ["data"]
        #puts @result
        #render plain: @result.inspect
    	#return @result
  	end 

end


#testing running ruby script alone
#peoples = Base_controller.new()

#@newdata = JSON.pretty_generate(peoples.process_records)

#puts newdata


=begin 
    def count_letters

        process_records()

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


        # not finished with this one but this was my train of thought on searching for possible duplicates
    def find_possible_dups

        pdata = process_records()

        #puts "#{pdata}"

        @dataobj ={}

        names = []

        x = 0

        while x < pdata.length

            #p pdata[x]

            curname = pdata[x]["first_name"]

            names.push(pdata[x]["first_name"])

            y = 0

            while y < curname.length

                curletter = curname[y]

                search = curname.sub("#{curletter}", ".")

                #curname[y] = "."

                #puts curname

                puts search

                z = 0

                while z < pdata.length

                    unless z == x

                        obj = /"#{search}"/.match(pdata[z]["first_name"])

                        #puts obj

                        #puts pdata[z]["first_name"]

                        if (obj != nil)

                            @dataobj = {"#{pdata[x]["first_name"]}" => pdata[z]["first_name"]}

                            puts @dataobj

                        else


                        end


                        z += 1
                    else

                        z += 1
                    end
                end   

                y += 1

                #puts names[x] #pdata[x]["first_name"]

            end 

            x += 1

            if (x == pdata.length)

                @result = "none found !" 
            
            end   

        end    
    end     

=end



