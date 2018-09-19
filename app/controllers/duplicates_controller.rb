require "rubygems"
require "bundler/setup"
Bundler.require
require "active_support/all"
require "json"



class DuplicatesController < BaseController


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
end         
