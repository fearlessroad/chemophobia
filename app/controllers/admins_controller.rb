class AdminsController < ApplicationController
	def index
		if session[:admin_id]
			redirect_to '/items/new'
		end
  	end
  	def login
	  	@user = Admin.find_by(email: params[:email])
	  	if @user && @user.authenticate(params[:password])
	  		session[:admin_id] = @user.id
	  		redirect_to '/items/new'
	  	else 
	  		flash[:errors] = ["Invalid email/ password combination"]
	  		redirect_to :back
	  	end
	end
	def destroy 
	    reset_session
	    redirect_to :root
	end
	def item
		session[:item_id] = nil
	    session[:chemical_id] = nil
	    redirect_to :back
	end
	def chemical 
	end
end
