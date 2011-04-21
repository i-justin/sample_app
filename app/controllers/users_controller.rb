class UsersController < ApplicationController
  before_filter :authenticate, :only=>[:edit, :update, :index, :destroy]
  before_filter :correct_user, :only=>[:edit, :update]
  before_filter :already_user, :only=>[:new, :create]
  before_filter :admin_user, :only=>[:destroy]
  
  
  def index
    @users=User.paginate(:page =>params[:page], :per_page=>10)
  	 @title="All Users"
  end
  
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
  		@title="Edit User"
  end
  
  def update
		if  @user.update_attributes(params[:user])
			redirect_to @user, :flash=>{:success=>"Profile updated."}
		else
			@title="Edit user"
			render 'edit'
	   end
  end
  
  
  def destroy
      @user=User.find(params[:id])
  		if current_user == @user
  		 	redirect_to users_path, :flash=>{:error=>"You cannot destroy yourself."}
  		else 
  		   @user.destroy
  		   redirect_to users_path, :flash=>{:sucess=>"User has been destroyed"}
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
   
   def admin_user
   	redirect_to(root_path) unless current_user.admin?
   end
   
   def already_user
   	redirect_to(root_path) unless current_user.nil?
   end
   
end
