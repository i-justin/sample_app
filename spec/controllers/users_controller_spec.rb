require 'spec_helper'

describe UsersController do
   render_views
   
   describe "GET 'show'" do
   
      before(:each) do
      	@user = Factory(:user)
      end
   
   	it "should be sucessful" do
   		get :show, :id=>@user.id
   		response.should be_success
   	end
   
      it "should find the right user" do
      	get :show, :id=>@user
      	assigns(:user).should == @user
      end
      
      it 'should have the right title' do
          get :show, :id=>@user
          response.should have_selector('title',:content => @user.name)
      end
      
      it "should have the user's name" do
      	get :show, :id=>@user
      	response.should have_selector('h1', :content => @user.name)
      end
      
      it "should have a profile image" do
      	get :show, :id=>@user
      	response.should have_selector('h1>img', :class=>"gravatar")   
      end
      
      it "should have the right url" do
      	get :show, :id=>@user
      	response.should have_selector('td>a', :content=>user_path(@user),
      													  :href=>user_path(@user))
			      	
      end
   end
   
   
   

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    it 'should have the right title' do
    	get :new
    	response.should have_selector('title',:content => "Sign Up")
    end
    
    it "should have a name field" do
    	get :new
    	response.should have_selector("input[name='user[name]'][type='text']")    	
    end
       
    it "should have an email field" do
    	get :new
    	response.should have_selector("input[name='user[email]'][type='text']")    	
    end
    
    it "should have a password field" do
    	get :new
    	response.should have_selector("input[name='user[password]'][type='password']")    	
    end
    
    it "should have a password confirmation field" do
    	get :new
    	response.should have_selector("input[name='user[password_confirmation]'][type='password']")    	
    end        
  end

  describe "POST 'create'" do
     describe "failure" do
     	 before (:each) do
     	 	@attr={:name=>"", :email=>"", :password=>"", :password_confirmation=>""}
     	 end
     	 
     	 it "should not create a user" do
     	    lambda do
     	    	post :create, :user=> @attr
     	    end.should_not change(User, :count)
     	 end
     	 
		 it 'should have the right title' do
		 	get :create, :user=>@attr
		 	response.should have_selector('title',:content => "Sign Up")
		 end
		 
		 it "should render the 'new' page" do
		 	post :create, :user=>@attr
		 	response.should render_template('new')
		 end        

    end
    
    describe "success" do
    	before(:each) do
    		@attr={:name=>"Justin V", :email=>"justin@example.com", :password=>"password", :password_confirmation=>"password"}
     	 end
     	 
     	it "should create a user_path" do
     		lambda do
     	    	post :create, :user=> @attr
     	    end.should change(User, :count).by(1)
     	end 	
     	
     	it "should redirect to the user show page" do
     		post :create, :user=>@attr
     		response.should redirect_to(user_path(assigns(:user)))
     	end
     	
     	it "should have a welcome message" do
     		post :create, :user=>@attr
     			flash[:success].should=~/welcome to the sample app/i
     	end
     	it "should sign the user in" do
		 	post :create, :user=>@attr
		 	controller.should be_signed_in
		 end	
    
    end
       
    
  end
  
  describe "Get 'edit'" do
    before(:each)	do
   	@user=Factory(:user)
   	test_sign_in(@user) 	
    end
   
    it "should be successful" do
    	get :edit, :id => @user
    	response.should be_success
    end
    it 'should have the right title' do
    	get :edit, :id => @user
    	response.should have_selector('title',:content => "Edit User")
    end
    
    it "should have a like to change the gravatar" do
    	get :edit, :id=>@user
    	response.should have_selector('a', :href=>"http://gravatar.com/emails", :content=>"Change")
    end
    
    
  end
  
  describe "PUT 'update'" do
  		
  		before(:each) do
  			@user=Factory(:user)
	   	test_sign_in(@user)
	   end
	   
	   describe "failure" do
	   	before(:each) do
	   		@attr=@attr={:name=>"", :email=>"", :password=>"", :password_confirmation=>""}
	   	end
	   	
	   	it "should render the edit page" do
	   		put :update, :id=>@user, :user => @attr
	   	end
	   
			it 'should have the right title' do
			 	put :update, :id=>@user, :user => @attr
			 	response.should have_selector('title',:content => "Edit user")
			end
	   
	   end
	   
	   describe "success" do
	   	before(:each) do
	   		@attr=@attr={:name=>"New ame", :email=>"new_email@example.com", :password=>"new_password", :password_confirmation=>"new_password"}
	   	end
	   	
	   	it "should change the users' attributes" do
	   		put :update, :id=>@user, :user=>@attr
	   		user=assigns(:user)
	   		@user.reload
	   		@user.name.should == user.name
	   		@user.email.should == user.email
	   		@user.encrypted_password.should == user.encrypted_password
	   		
	   	end
	   	
	   	it "should have a flash message" do
	   		put :update, :id => @user, :user=>@attr
	   		flash[:success].should=~ /updated/
	   	end
	   	
	   end   	
	end
	
	describe "authentication of edit/update actions" do
  		before(:each) do
  			@user=Factory(:user)
      end
      
      it "should deny access to 'edit'" do
      	get :edit, :id=>@user
      	response.should redirect_to(signin_path)
      	flash[:notice].should=~ /sign in/i
      end
   
      it "should deny access to 'update'" do
      	put :update, :id=>@user, :user=>{}
      	response.should redirect_to(signin_path)
      end
   	
  end
	   
     

		 
end
