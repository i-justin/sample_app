require 'spec_helper'

describe User do
 
	it "should create a new instance given a valid attribute" do
		User.create!(:name=>"Example User", :email=>"user@example.com")
	end 
 
  
end
