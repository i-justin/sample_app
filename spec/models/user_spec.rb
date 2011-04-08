require 'spec_helper'

describe User do
 
	it "should create a new instance given a valid attribute" do
		User.create!(:name=>"Example User", :email=>"user@example.com")
	end 
 
   
	it "should require a name" do
		no_name_user=User.new(:email=>"user@example.com")
		no_name_user.should_not be_valid	
	end  
end
