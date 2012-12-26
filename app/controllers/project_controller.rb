class ProjectController < ApplicationController
	require 'csv'    


	require 'csv-mapper'
	include CsvMapper

	def home
		CSV.foreach("data.csv", :headers => true) do |row|
  			#Moulding.create!(row.to_hash)
		end

		$data = import('data.csv') do
  			start_at_row 1
 			[first_major, second_major, third_major, first_minor, second_minor, third_minor, first_cert, second_cert, third_cert, location, company, industry, salary, grad_year]
 			#print $results.first.first_major
		end

		$people = Hash.new
		for i in 0..$data.length 
			key = ("p" + i.to_s).to_s
			$people[key] = $data[i]    #people is a hash that maps numbers to people 
		end
	end



	def get_degrees
		@major_params = ['major1', 'major2', 'major3']
		@minor_params = ['minor1', 'minor2', 'minor3']
		@cert_params = ['cert1', 'cert2', 'cert3']
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

	

	def test
		@major_params = ['major1', 'major2', 'major3']
		@minor_params = ['minor1', 'minor2', 'minor3']
		@cert_params = ['cert1', 'cert2', 'cert3']	
	end


	def prereqs
		cookies[:majors] = [params[:major1], params[:major2], params[:major3]].reject {|d| d.eql?("-- Select --")}
		cookies[:minors] = [params[:minor1], params[:minor2], params[:minor3]].reject {|d| d.eql?("-- Select --")}
		cookies[:certs] = [params[:cert1], params[:cert2], params[:cert3]].reject {|d| d.eql?("-- Select --")}
		cookies[:list_majors] = list("majors", cookies[:majors], cookies[:minors], cookies[:certs])
		cookies[:list_minors] = list("minors", cookies[:majors], cookies[:minors], cookies[:certs])
		cookies[:list_certs] = list("certs", cookies[:majors], cookies[:minors], cookies[:certs])
		cookies[:maj_prereq] = get_classes(cookies[:majors], "pre-req", "majors")
		cookies[:min_prereq] = get_classes(cookies[:minors], "pre-req", "minors")
		cookies[:cert_prereq] = get_classes(cookies[:certs], "pre-req", "certs")
		cookies[:maj_prereq_taken] = []
		cookies[:min_prereq_taken] = []
		cookies[:cert_prereq_taken] = []
		cookies[:semesters] = calc_semesters(params[:grad].to_i).to_i
		User.create(name: params[:name], majors: cookies[:majors].to_s, minors: cookies[:minors].to_s, certs: cookies[:certs].to_s)
		debugger
	end

	def core 
		cookies[:maj_core] = get_classes(cookies[:majors].split('&'), "core", "majors")
		cookies[:min_core] = get_classes(cookies[:minors].split('&'), "core", "minors")
		cookies[:cert_core] = get_classes(cookies[:certs].split('&'), "core", "certs")
		cookies[:maj_core_taken] = []
		cookies[:min_core_taken] = []
		cookies[:cert_core_taken] = []
		{:maj_prereq => :maj_prereq_taken, :min_prereq => :min_prereq_taken, :cert_prereq => :cert_prereq_taken}.each do |k, v| 
			cookies[v] = calc_taken(k)
		end
	end

	def electives
		cookies[:maj_electives] = get_classes(cookies[:majors].split('&'), "electives", "majors")
		cookies[:min_electives] = get_classes(cookies[:minors].split('&'), "electives", "minors")
		cookies[:cert_electives] = get_classes(cookies[:certs].split('&'), "electives", "certs")
		cookies[:maj_electives_taken] = []
		cookies[:min_electives_taken] = []
		cookies[:cert_electives_taken] = []
		{:maj_core => :maj_core_taken, :min_core => :min_core_taken, :cert_core => :cert_core_taken}.each do |k, v| 
			cookies[v] = calc_taken(k)
		end		
	end


	def results
		algo
		@data2 = Hash.new 

		for i in 0..$keys.length  
			@data2[$keys[i]] = $people[$keys[i]]
		end

		@data2.delete_if { |k, v| v.nil? }

		@error = 1
		@problems = {"hello" => "world"}

		@data = {"p1" => ["Economics, Computer Science", "Mathematics", "Markets and Management", "New York City, New York", "JP Morgan Chase", "Investment Banking Analyst", "$140000", "3.67", "2011"],
				 "p2" => ["Economics", "Mathematics", "Markets and Management", "Chicago, Illinois", "Belvedere Trading", "Proprietary Trader", "$115000", "3.89", "2011"],
				 "p3" => ["Economics", "Mathematics", "", "New York City, New York", "McKinsey & Company", "Management Consultant", "$85000", "3.91", "2010"],
				 "p4" => ["Mathematics", "Economics", "", "Washington, DC", "United States of America", "President", "$250000", "2.35", "2009"]
				}
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

		$weight.sort_by { |name, value| value}

		for i in 0..$weight.length 
			key = ("p" + i.to_s).to_s
			if ($weight[key].to_i > 0)			
				$keys.push(key)		
			end
		end
	end
end
