class ItemsController < ApplicationController
	def new
	    @admin = Admin.find(session[:admin_id])
	    @items = Item.all
	    @chemicals = Chemical.all
	    @gmos = Gmo.all
	    @literacies = Literacy.all
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
		  		redirect_to '/chemicals/new'
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
	def destroy 
	    Item.find(session[:item_id]).destroy
	    session[:item_id] = nil
	    session[:chemical_id] = nil
	    redirect_to :back
	 end
	 def index
	 	@items = Item.all
	 end
	 def show
	 	@item = Item.find(params[:id])
	 	@chemicals = ItemChemShip.where(item: @item).joins(:chemical).select("item_chem_ships.*, chemicals.name").order(percentage: :desc)
	 	@gmos = Gmo.where(item: Item.find(params[:id]))
	 	@water = Chemical.find_by(name:"water")
	 end
	 def search
	 	item = Item.find_by(name: params[:item])

	 	if item
	 		redirect_to "/items/show/#{item.id}"
	 	else
	 		flash[:errors] = ["Oops! We could not find that item in our database. Here are the items we have:"]
	 		redirect_to "/items/index"
	 	end	 		

	 end
	private
	 	def item_params 
	  		params.required(:item).permit(:name, :description, :image)
	  	end 
end
