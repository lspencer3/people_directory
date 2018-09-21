require "rubygems"
require "bundler/setup"
Bundler.require
require "active_support/all"
require "json"


# not finished with this one but this was my train of thought on searching for possible duplicates
#right now it only searches on first names only
class DuplicatesController < BaseController

    def find_possible_dups

        #assign api data to variable

        pdata = process_records()

        #puts "#{pdata}"

        #this is the hash that will be sent to the view if it contains data

        @dataarray =[]


        x = 0
        #loop for array of people to begin with firstname search-- loop to grap search names
        while x <  pdata.length
            #p "hello"
            #puts "this is the current search name #{pdata[x]}"

            #assign variable to first name for searching duplicates on

            curname = pdata[x]["first_name"]

            #p curname

            #p curname.length

            y = 0
            #loop on first name and add in wild card at every index of name to search mutiple typo possiblities
            while y < curname.length

                #assign current string index to variable

                curletter = curname[y]

                #assign updated string with wildcard included to new "search" variable

                search = curname.sub("#{curletter}", ".")

                #puts curname

                #puts search

                z = 0

                #once the search is obtained loop through people data array to search firstnames of all names with regex

                #make copy of pdata array and then extract element that is being searched from this copied array to begin looping on it 

                copypdata = [] #create a new array 
                copypdata.replace(pdata)

                #p copypdata[x] 

                copypdata.delete_at(x)

                #puts JSON.pretty_generate(copypdata)

                #puts JSON.pretty_generate(pdata)

                #puts copypdata.length

                #puts pdata.length

                while z < copypdata.length

                    #p pdata[z]["first_name"]

                    #run regex search on current search and try to match with a first name element in the copydata array of objects 
                    searchresult = /#{search}/.match(copypdata[z]["first_name"])

                    #puts "this is the search result #{searchresult}"


                    #if the search yielded a result, add the matching first names to object @datahash that will be returned to the view

                    if (searchresult != nil)

                        p "added this person #{searchresult}"

                        name1 = "Searched Name: #{pdata[x]["first_name"]}  #{pdata[x]["last_name"]}"

                        name2 = "Matched Name: #{pdata[z]["first_name"]}  #{pdata[z]["last_name"]}"

                        @dataarray.push({name1 => name2})

                        puts "this is your data matches #{@dataarray}"

                    else 

                    end  
                    z += 1
                end   

                y += 1
            end 

            x += 1

        end
        #to return appropriate data after all the loops have completed
        if (@dataarray == [])

            return  @result = "none found !" 

            #puts @result = "none found !" 
        else 

            return @dataarray
            puts @dataarray
            
        end       
    end
end         
