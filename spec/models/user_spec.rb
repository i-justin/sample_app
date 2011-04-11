require 'spec_helper'

describe User do

   before(:each) do
   	@attr={:name=>"Example User", :email => "user@example.com"}
   end
 
	it "should create a new instance given a valid attribute" do
		User.create!(@attr)
	end 
 
   
	it "should require a name" do
		no_name_user=User.new(@attr.merge(:name=>""))
		no_name_user.should_not be_valid	
	end  
	
	it "should require an email address" do
		no_email_user=User.new(@attr.merge(:email=>""))
		no_email_user.should_not be_valid
   end
   
   it "should reject names that are too long" do
      long_name="a" * 51
  		to_long_user=User.new(@attr.merge(:name=>long_name)) 	
  	   to_long_user.should_not be_valid
  	end
  	it "should accept valid email addresses" do
  		addresses=%w[user@foo.com the_user@foo.bar.org first.last@foo.jp]
  		addresses.each do |address|
  			valid_email_user=User.new(@attr.merge(:email => address))
  			valid_email_user.should be_valid
  	   end
  	end
  	
  	it "should reject invalid email addresses" do
   	addresses=%w[user@foo,com the_user_at_foo.bar.org first.last@foo]
 		addresses.each do |address|
  			invalid_email_user=User.new(@attr.merge(:email => address))
  			invalid_email_user.should_not be_valid
  	   end
  	end
  	
  	it "should reject duplicate email addresses" do
  		usr_test=User.create!(@attr)
  		user_with_duplicate_email=User.new(@attr)
  		user_with_duplicate_email.should_not be_valid
  	end
  	
  	it "should reject email address identical to upcase" do
  		upcased_email=@attr[:email].upcase
  		usr_test=User.create!(@attr.merge(:email=>upcased_email))
  		user_with_duplicate_upemail=User.new(@attr)
  		user_with_duplicate_upemail.should_not be_valid
  	end

  	
end
