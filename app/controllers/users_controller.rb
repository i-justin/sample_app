class UsersController < ApplicationController
  before_filter :authenticate, :only=>[:edit, :update]
  before_filter :correct_user, :only=>[:edit, :update]
  def new
   @user=User.new
  	@title="Sign Up"
  end
  
  def show  
	 @user=User.find(params[:id])
	 @title=@user.name
  end
  
  def create
     @user=User.create(params[:user])
     if @user.save
         flash[:success]="Welcome to the sample app!"
         sign_in @user
     		redirect_to @user   		
     else
     		@user.password=''
     		@user.password_confirmation=''
     		@title="Sign Up"
     		render 'new'
     end     
  end
  
  def edit
  		@user=User.find_by_id(params[:id])
  		@title="Edit User"
  end
  
  def update
  	   @user=User.find(params[:id])
		if  @user.update_attributes(params[:user])
			redirect_to @user, :flash=>{:success=>"Profile updated."}
		else
			@title="Edit user"
			render 'edit'
	   end
  end
  

  
  private	
  	
  	def authenticate
  		deny_access unless signed_in?
   end
   
   def correct_user
   	@user=User.find(params[:id])
   	redirect_to(root_path) unless current_user?(@user)
   end
   
end
