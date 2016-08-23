class ItemsController < ApplicationController
	def index
	end
	def new
	    if session[:item_id]
	  	 @currentItem = Item.find(session[:item_id])
	  	 @addedChemicals = ItemChemShip.joins(:chemical).select("chemicals.name, chemicals.id").where(item: Item.find(session[:item_id]))
	  	end
	  	if session[:chemical_id]
	  	 @currentChemical = Chemical.find(session[:chemical_id])
	  	

	# ItemChemRelationships.joins(:chemical).select("chemicals.name, chemicals.id, chemicals.chemical_category_id").joins(:chemical_category).select("chemical_category.name as chemcat_name, chemical_category.id as chemcat_id")

	    end
	    @admin = Admin.find(session[:admin_id])
	    @chemicals = Chemical.all
	  	@categories = ChemCat.all
	  	@subcategories = ChemSubcat.all
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
	def destroy 
	    Item.find(session[:item_id]).destroy
	    session[:item_id] = nil
	    session[:chemical_id] = nil
	    redirect_to :back
	  end
	 def reset
	 	session[:item_id]=nil
	 	session[:chemical_id]= nil
	 	session[:category_id]= nil
	 	session[:confirmed]=nil
	 	redirect_to :back
	 end
	 def show
	 	@items = Item.all
	 end
	 def display
	 	@item = Item.find(params[:id])

	 	# @chemicals_by_item = ItemChemShip.joins(:chemical).select("item_chem_ships.*, chemicals.name")
	 	# @chemicals_by_category = @chemicals_by_item.joins(:chem_cat_ship).select("chemicals.name, chemicals.id, chem_cat_ships.chem_cat_id")

	 	@chemicals = ItemChemShip.joins("LEFT JOIN chem_cat_ships ON item_chem_ships.chemical_id = chem_cat_ships.chemical_id").joins("LEFT JOIN chemicals on item_chem_ships.chemical_id = chemicals.id").select("item_chem_ships.*, chem_cat_ships.*, chemicals.name, chemicals.id as chemical_id").where(item: Item.find(params[:id])).order(:percentage)
	 end
	private
	 	def item_params 
	  		params.required(:item).permit(:name, :description, :image)
	  	end 
end
