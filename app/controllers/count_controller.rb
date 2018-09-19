require "rubygems"
require "bundler/setup"
Bundler.require
require "active_support/all"
require "json"



class CountController < BaseController

    def count_letters

        data = process_records()

        #puts data

        longemailstring = ""

        alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p","q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

        frequencyhash = {}

        data.each do |person|

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
end