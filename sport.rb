require 'open-uri'
require 'net/http'
require 'open_uri_redirections'
require 'nokogiri'


	sport=Array.new
	count=0
	File.open("sport_data.txt").each do |t|
	   sport[count]=t;
	   # puts sport[count]  #inserting all sports in array
	   count+=1
	end
	 puts "Enter File name:"
	 name=gets.chomp

	 File.open(name).each do |line|
	 	 valid=true  #to check if url is valid or not
	 	 found=false 
	     site=line.strip
	     if site==""
	     	next
	     end
	     # for checking if url is valid?
	     begin 
	     open site,:allow_redirections => :all, :proxy=>true
	     rescue => e
	     puts "#{site} : Invalid Site"
	     valid=false
	     end
	     
	    if(valid==true)
		    	sport.each do |name|
		    		if site.include?(name.strip())
		    			puts "#{site} : #{name}"
		    			found=true
		    		end
		    	end
                if(found!=true)
			   		page = Nokogiri::HTML(open(site.strip(),:allow_redirections => :all))
			   		title=page.title
			   		title.downcase!
		            # puts title
		            sport.each do |name|
		            	if title.include?(name.strip())
		            		puts "#{site} : #{name}"
		            		found=true
		            	end
		            end
		        end       
		        
		        if(found!=true)
                     str=page.css('div').text
                     str=str.strip()
                     sport.each do |name|
                     	if str.include?(name.strip())
                     		puts "#{site} : #{name}"
                     		found=true
                     	end
                     end
		        end
		        if(found==false)
		        	puts "#{site} : NA"
                end

	   	end
     end
