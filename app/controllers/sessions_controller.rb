class SessionsController < ApplicationController
  def new
      @title="Sign in"
  end
  
  def create
     user=User.authenticate(params[:session][:email],params[:session][:password])
     if user
  	     #do sign in
  	  else
  	  	  @title="Sign in"
  	  	  flash.now[:error]="Invalid email/password combination"
  	     render 'new'
  	  end
  end
  
  def destroy
  end

end
