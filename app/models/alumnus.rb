class Alumnus < ActiveRecord::Base
  attr_accessible :major, :minor, :certificate, :company, :gpa, :industry
end
