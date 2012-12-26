module ControllerModules 
	module Helpers
		extend ActiveSupport::Concern


		def calc(person, maj1, maj2, min1, min2, cert1, cert2) 
			ret = 0
			# we assume that if maj2 is filled, maj1 is definitely filled 

			if maj2.eql?("") 
				maj2 = "none"
			end

			if min1.eql?("") 
				min1 = "none"
			end

			if min2.eql?("") 
				min2 = "none"
			end

			if cert1.eql?("") 
				cert1 = "none"
			end

			if cert2.eql?("") 
				cert2 = "none"
			end

			fir_maj = person.first_major
			sec_maj = person.second_major
			fir_min = person.first_minor
			sec_min = person.second_minor
			fir_cert = person.first_cert
			sec_cert = person.second_cert


			#do majors match 
			if (!fir_maj.eql?(maj1) && !fir_maj.eql?(maj2)) 
				if (sec_maj.eql?(maj1) == false && sec_maj.eql?(maj2) == false) 
					return 0
				end
			end

			# at this stage, we have a match on at least one major 

			#here is the case for when they match on both majors, I added them 50 points
			if (fir_maj.eql?(maj1) && sec_maj.eql?(maj2)) 
				ret = ret + 50
			elsif (fir_maj.eql?(maj2) && sec_maj.eql?(maj1)) 
				ret = ret + 50
			end



			if (!fir_min.eql?(min1) && !fir_min.eql?(min2)) 
				if (!sec_min.eql?(min1) && !sec_min.eql?(min2)) 
					ret = ret + 30
				end
			end


			if (fir_min.eql?(min1) && sec_min.eql?(min2)) 
				ret = ret + 20
			elsif (fir_min.eql?(min2) && sec_min.eql?(min1)) 
				ret = ret + 20
			end



			if (!fir_cert.eql?(cert1) && !fir_cert.eql?(cert2)) 
				if (!sec_cert.eql?(cert1) && !sec_cert.eql?(cert2)) 
					ret = ret + 10
				end
			end


			if (fir_cert.eql?(cert1) && sec_cert.eql?(cert2)) 
				ret = ret + 5
			elsif (fir_cert.eql?(cert2) && sec_cert.eql?(cert1)) 
				ret = ret + 5
			end


			ret

		end



		def list(degree_type, majors, minors, certs)
			if degree_type == "majors"
				type = majors
			elsif degree_type == "minors"
				type = minors
			else degree_type == "certs"
				type = certs
			end

			ret = type.first
			type = type - [ret]
			type.each do |c|
				ret = ret + ", " + c
			end
			ret
		end

		def get_classes(degrees, type, degree_type)
			prereq = []
			if degrees.size > 0
				if degree_type == "majors"
					degrees.each do |maj|
						prereq = prereq + DegreeConstants.get_maj_classes(maj)[type]
					end	
				end
				if degree_type == "minors"
					degrees.each do |min|
						prereq = prereq + DegreeConstants.get_min_classes(min)[type]
					end	
				end
				if degree_type == "certs"
					degrees.each do |cert|
						prereq = prereq + DegreeConstants.get_cert_classes(cert)[type]
					end
				end
			end
			prereq
		end		

		def calc_taken(key)
			taken = Array.new
			cookies[key].split('&').each do |course|
				if params[course]
					taken.push(course)
				end
			end	
			taken
		end

		def calc_semesters(grad)
			if (Time.now.month >= 9)
				ret = ((grad - Time.now.year) * 2) - 1
			else 
				ret = (grad - Time.now.year) * 2
			end
			if (ret > 8)
				return 8
			elsif (ret < 1)
				return 0
			else
				return ret
			end
		end


	end
end
