class ProjectController < ApplicationController
	require 'csv'    


	require 'csv-mapper'
	include CsvMapper

	def home
		CSV.foreach("data.csv", :headers => true) do |row|
  			#Moulding.create!(row.to_hash)
		end

		$data = import('data2.csv') do
  			start_at_row 1
 			[first_major, second_major, first_minor, second_minor, first_cert, second_cert, location, company, industry, salary, gpa, grad_year]
 			#print $results.first.first_major
		end

		$people = Hash.new
		for i in 0..$data.length 
			key = ("p" + i.to_s).to_s
			$people[key] = $data[i]    #people is a hash that maps numbers to people 
		end
	end

	def get_academic
		@major_params = ['major1', 'major2']
		@minor_params = ['minor1', 'minor2']
		@cert_params = ['cert1', 'cert2']

		cookies[:name] = params[:name]
		cookies[:grad] = params[:grad]
		cookies[:school] = params[:school]
	end

	def get_ec 
		@ec_params = ['ec1', 'ec2', 'ec3', 'ec4', 'ec5']
		cookies[:majors] = [params[:major1], params[:major2], params[:major3]].reject {|d| d.eql?("-- Select --")}
		cookies[:minors] = [params[:minor1], params[:minor2], params[:minor3]].reject {|d| d.eql?("-- Select --")}
		cookies[:certs] = [params[:cert1], params[:cert2], params[:cert3]].reject {|d| d.eql?("-- Select --")}		
	end

	
	def results
		algo
		@data2 = Hash.new 

		for i in 0..$keys.length  
			@data2[$keys[i]] = $people[$keys[i]]
		end
		@data2.delete_if { |k, v| v.nil? }
	end



	def algo 
	
		#need their majors, minors, certs, gpa 
		$weight = Hash.new 
		majors_arr = cookies[:majors].split('&')
		minors_arr = cookies[:minors].split('&')
		certs_arr = cookies[:certs].split('&')
		major_1 = majors_arr[0]
		major_2 = majors_arr[1]
		minor_1 = minors_arr[0]
		minor_2 = minors_arr[1]
		cert_1 = certs_arr[0]
		cert_2 = certs_arr[1]

		# at this stage, you get all the majors, minors, certs 

		for i in 0..$people.length 
			key = ("p" + i.to_s).to_s
			if ($people[key])					
				$weight[key] = calc($people[key], major_1, major_2, minor_1, minor_2, cert_1, cert_2)     #people is a hash that maps numbers to people 
			end
		end

		$keys = Array.new
		$temp_arr = ($weight.sort_by { |name, value| value}).reverse  # this is an array...

		for i in 0..$temp_arr.length 
			if ($temp_arr[i])			
				if ($temp_arr[i][1] > 0) 
					$keys.push($temp_arr[i][0])
				end
			end
		end

	end
end
