# == Schema Information
# Schema version: 20110408191311
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	attr_accessor :name, :email

	validates_presence_of :name
	
	
end
