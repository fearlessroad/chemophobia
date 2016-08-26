class ItemsController < ApplicationController
	def new
	    if session[:item_id]
	  	 @currentItem = Item.find(session[:item_id])
	  	end
	    @items = Item.all
	    @admin = Admin.find(session[:admin_id])
	end
	def update
		item = Item.find(session[:item_id])
		item.update(item_params)
		redirect_to :back
	end
	def create 
		item = Item.find_by(item_params)
		if item
			flash[:errors] = ["This item already exists in the database. Please navigate to EDIT an item"]
			redirect_to :back
		else 
		  	item = Item.new(item_params)
		  	if item.save
		      	session[:item_id] = item.id
		  		redirect_to :back
		  	else 
		  		flash[:errors] = item.errors.full_messages
		  		redirect_to :back
		  	end
		end
	end
	def edit
		@item = Item.find(params[:id])
		session[:item_id] = @item.id
		redirect_to "/items/new"
	end
	def confirm
		redirect_to "/chemicals/new";
	end
	def destroy 
	    Item.find(session[:item_id]).destroy
	    session[:item_id] = nil
	    session[:chemical_id] = nil
	    redirect_to :back
	 end
	 def index
	 	@items = Item.all
	 end
	 def display
	 	@item = Item.find(params[:id])
	 	@chemicals = ItemChemShip.where(item: @item).joins(:chemical).select("item_chem_ships.*, chemicals.name").order(percentage: :desc)
	 	@gmos = Gmo.where(item: Item.find(params[:id]))
	 end
	private
	 	def item_params 
	  		params.required(:item).permit(:name, :description, :image)
	  	end 
end
