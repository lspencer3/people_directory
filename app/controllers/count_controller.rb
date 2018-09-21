require "rubygems"
require "bundler/setup"
Bundler.require
require "active_support/all"
require "json"



class CountController < BaseController

    def count_letters

        #assign variable to data array returned

        data = process_records()

        #puts data

        #appending all emails to the empty string variable below
        longemailstring = ""

        alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p","q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

        #assigned variable to hash that will hold the frequency counts

        frequencyhash = {}

        #looping through data to grab emails and append to "longemailstring" variable

        data.each do |person|

            #puts "current email address is: #{person["email_address"]} " 

            longemailstring += "#{person["email_address"]}"
        end

        #puts "this is the email array #{longemailstring}"


        #loops through alphabet array to get frequency count for each letter in "longemailstring"


        alphabet.each do |letter|

            #puts "#{letter}: " + longemailstring.count(letter).to_s

            #pushes letter and count to bigger frequency hash

            currenthash = {"#{letter}" => longemailstring.count(letter)}

            frequencyhash = frequencyhash.merge!(currenthash)

            #puts "hash: #{frequencyhash}" 
        end 

        #puts frequencyhash 

        #returns sorted frequency hash to view

        @sortedhash = frequencyhash.sort_by {|_key, value| value}.reverse

        #puts @sortedhash
    end
end