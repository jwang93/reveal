class DegreeConstants 

	# template_major = {"notes" => "", "pre-req" => [], "core" => [], "electives" => []}


	def self.get_ec()
		JSON.parse(File.read("#{Rails.root}/lib/extracurriculars.json"))["extracurriculars"]
	end

	def self.get_majors()
		JSON.parse(File.read("#{Rails.root}/lib/majors.json"))["majors"]
	end

	def self.get_maj_classes(major)
		JSON.parse(File.read("#{Rails.root}/lib/degrees/majors/#{major}.json")) 
	end

	def self.get_minors()
		JSON.parse(File.read("#{Rails.root}/lib/minors.json"))["minors"]
	end

	def self.get_min_classes(minor)
		@@minor_directory[minor]
	end

	def self.get_certs()
		JSON.parse(File.read("#{Rails.root}/lib/certificates.json"))["certificates"]
	end

	def self.get_cert_classes(cert)
		@@cert_directory[cert]
	end


end