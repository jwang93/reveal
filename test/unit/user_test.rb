# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  majors     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  minors     :string(255)
#  certs      :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
