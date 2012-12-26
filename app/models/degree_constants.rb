class DegreeConstants 

	# template_major = {"notes" => "", "pre-req" => [], "core" => [], "electives" => []}

	@@econ_major = {"notes" => "Electives must be at the 300-level or above, with at least one course at the 300-level and one course at the 400 level. Courses 500-549 can only be counted toward the major with the approval of the Director of Undergraduate Studies", "pre-req" => ['Math 111L/105L/106L', 'Math 112L/122/122L', 'Math 202/212/222', 'Stat 111/230/130/250'], "core" => ['Econ 101', 'Econ 201D', 'Econ 205D', 'Econ 210D', 'Econ 208D'], "electives" => ['Econ Elective 1', 'Econ Elective 2', 'Econ Elective 3']}
	@@math_major = {"notes" => "Electives must be numbered above 230. One Elective must be one of Math 333/342/411/421/502/532/541/581. There is also a Physics requirements (AP credit may be used).", "pre-req" => ['Math 21/111L', 'Math 22/112L/122/122L', 'Math 212/222', 'Math 221'], "core" => ['Math 401/Math 501', 'Math 431/531'], "electives" => ['Math Elective 1', 'Math Elective 2', 'Math Elective 3', 'Math Elective 4', 'Math Elective 5', 'Math Elective 6']}
	@@cs_major = {"notes" => "", "pre-req" => ['Comp Sci 101L', 'Math 111L', 'Math 112L', 'Math 202/216/221', 'Stat 103 (or anything higher)'], "core" => ['Comp Sci 201', 'Comp Sci 210', 'Comp Sci 230', 'Comp Sci 250', 'Comp Sci 330'], "electives" => ['Comp Sci Elective 1', 'Comp Sci Elective 2', 'Comp Sci Elective 3', 'Comp Sci/Math/Stat Elective 4', 'Comp Sci/Math/Stat Elective 5']}
	@@pubpol_major = {"notes" => "Note that taking both Econ 101 (51) and Econ 201D (55) fulfills the requirement for PUBPOL 303 (128). Students who have taken both of these courses cannot take PUBPOL 303 (128). Taking Econ 101 (51) and Econ 201D (55) count as the prerequisite for PUBPOL 304 (132).", "pre-req" => [], "core" => ['Pubpol 120', 'Pubpol 155D', "Pubpol 301", "Pubpol 302", "Pubpol 303", "Pubpol 304", 'Stats 101/102/103'], "electives" => ['History Elective', 'Pubpol Elective (165-699) 1', 'Pubpol Elective (165-699) 2', 'Pubpol Elective (165-699) 3', 'Pubpol Elective (500-699) 4']}

	@@major_directory = {"Economics" => @@econ_major, "Mathematics" => @@math_major, "Computer Science" => @@cs_major, "Public Policy" => @@pubpol_major}

	@@supported_maj = ["Computer Science - BA", "Computer Science - BS", 
					"Economics - BA", "Economics - BS", 
					"Public Policy - BA"]
					
	@@supported_min = []
	@@supported_cert = []

	def self.get_ec()
		JSON.parse(File.read("#{Rails.root}/lib/extracurriculars.json"))["extracurriculars"]

	end

	def self.get_majors()
		JSON.parse(File.read("#{Rails.root}/lib/majors.json"))["majors"]

	end

	def self.get_maj_classes(major)
		JSON.parse(File.read("#{Rails.root}/lib/degrees/majors/#{major}.json")) 
		#@@major_directory[major]
	end


	@@econ_minor = {"notes" => "Three Econ electives at the 300-level or above, with at least one course at the 300-level and one course at the 400 level. ", "pre-req" => [], "core" => ['Econ 101', 'Econ 201D'], "electives" => ['Econ Elective 1', 'Econ Elective 2', 'Econ Elective 3']}
	@@math_minor = {"notes" => "Electives must be numbered above 212, other than Math 222 and one elective must be Math230(135), 333(181), 340, 361S(160S), 401(121), 411(205), 421(206), 431(139), 451S(132S), 487(187), or any Mathematics course at the 500 or 600 level.", "pre-req" => ['Math 212/222'], "core" => [], "electives" => ['Math Elective 1', 'Math Elective 2', 'Math Elective 3', 'Math Elective 4', 'Math Elective 5']}
	@@cs_minor = {"notes" => "Electives must be at the 200 level or above.", "pre-req" => ['Comp Sci 101L'], "core" => ['Comp Sci 201', 'Comp Sci 250'], "electives" => ['Comp Sci Elective 1', 'Comp Sci Elective 2']}
	@@finance_minor = {"notes" => "", "pre-req" => ['Stat 111/230/210', 'Math 222/216'], "core" => ['Econ 101', 'Econ 372'], "electives" => ['Finance Elective 1', 'Finance Elective 2', 'Finance Elective 3']}

	@@minor_directory = {"Economics" => @@econ_minor, "Mathematics" => @@math_minor, "Computer Science" => @@cs_minor, "Finance" => @@finance_minor}

	def self.get_minors()
		JSON.parse(File.read("#{Rails.root}/lib/minors.json"))["minors"]
	end

	def self.get_min_classes(minor)
		@@minor_directory[minor]
	end






	@@islamic_studies_cert = {"notes" => "2 electives must be at the 100 level or above. Required study abroad in a majority-Muslim country. Also certificate recipients will be required to complete two years of study in an Islamic language (i.e., a language spoken in a majority-Muslim country).", "pre-req" => [], "core" => ['Religion 146/147', 'Religion 195S', ], "electives" => ['Islamic Studies Elective 1', 'Islamic Studies Elective 2', 'Islamic Studies Elective 3', 'Islamic Studies Elective 4']}
	@@human_development_cert = {"notes" => "Electives must come from the list of biological, psychological, and sociological courses affiliated with the HDV Program.", "pre-req" => [], "core" => ['HDV 124', 'HDV 180/PSY 159S', 'HDV 190', 'HDV 191S'], "electives" => ['HDV Elective 1', 'HDV Elective 2']}
	@@markets_management_cert = {"notes" => "Core and elective course listings can be found on the MMS website. A minimum of three M&M courses must be taken by the end of the junior year, and one of these must be a core course. No more than three courses may originate in a single department. No more than two courses that are used to satisfy the requirements of any major, minor, or other certificate program can count toward the Markets & Management Studies certificate.", "pre-req" => [], "core" => ['MMS 190', 'MMS Core Course 1', 'MMS Core Course 2'], "electives" => ['MMS Elective 1', 'MMS Elective 2', 'MMS Elective 3', 'MMS Elective 4']}
	@@journalism_cert = {"notes" => "No more than four courses may be in a single department. At least four courses must be 100-level or above. By the end of the junior year, of a minimum of 3 courses completed. Students must complete an internship with a media-related organization.", "pre-req" => [], "core" => ['PPS 125', 'PPS 118/119/120', 'PPS 202'], "electives" => ['PPS Elective 1', 'PPS Elective 2', 'PPS Elective 3']}

	@@cert_directory = {"Islamic Studies" => @@islamic_studies_cert, "Human Development" => @@human_development_cert, "Markets and Management" => @@markets_management_cert, "Policy Journalism and Media Studies" => @@journalism_cert}
	
	def self.get_certs()
		JSON.parse(File.read("#{Rails.root}/lib/certificates.json"))["certificates"]
	end

	def self.get_cert_classes(cert)
		@@cert_directory[cert]
	end


end
