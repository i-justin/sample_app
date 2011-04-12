class UsersController < ApplicationController
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
end
