class DegreesController < ApplicationController

	def add
	end

	def success 
		temp = params

		debugger
		File.new("lib/degrees/majors/" + params[:degree_name] + ".json", "w") 
		File.open("lib/degrees/majors/" + params[:degree_name] + ".json", "w") do |filea|
			filea.write('{
				"name" : "' + params[:degree_name] + '",
				"notes" : "' + params[:notes] + '",
				"pre-req" : "' + params[:prereqs] + '",
				"core" : "' + params[:core] + '",
				"electives" : "' + params[:electives] + '"
		}')
		end

	end

end
