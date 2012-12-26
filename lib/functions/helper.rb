Module Functions
	
	Module Helper
		def list(degree_type)

			if degree_type == "majors"
				type = @@majors
			elsif degree_type == "minors"
				type = @@minors
			else degree_type == "certs"
				type = @@certs
			end

			ret = type.first
			type = type - [ret]
			type.each do |c|
				ret = ret + ", " + c
			end

			return ret
		end
	end

end

