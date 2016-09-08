class AdminsController < ApplicationController
	def index
		if session[:admin_id]
			redirect_to '/admins/home'
		end
  	end
  	def home
  		if session[:admin_id]
  			@admin = Admin.find(session[:admin_id])
  		end
	    @items = Item.all
	    @chemicals = Chemical.all
	    @gmos = Gmo.all
	    @literacies = Literacy.all
  	end
  	def login
	  	@user = Admin.find_by(email: params[:email])
	  	if @user && @user.authenticate(params[:password])
	  		session[:admin_id] = @user.id
	  		redirect_to '/admins/home'
	  	else 
	  		flash[:errors] = ["Invalid email/ password combination"]
	  		redirect_to :back
	  	end
	end
	def destroy 
	    reset_session
	    redirect_to :root
	end
	# def item
	# 	session[:item_id] = nil
	#     session[:chemical_id] = nil
	#     session[:category_id] = nil
	# 	session[:confirmed] = nil
	# 	session[:categorized] = nil
	#     redirect_to :back
	# end
	# def chemical 
	# 	session[:chemical_id] = nil
	# 	session[:category_id] = nil
	# 	session[:confirmed] = nil
	# 	session[:categorized] = nil
	# 	redirect_to "/chemicals/new"
	# end
end
