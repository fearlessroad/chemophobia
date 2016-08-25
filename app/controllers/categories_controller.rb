class CategoriesController < ApplicationController
	def selectCat
		@category, @chemical = params[:category].split(":")
		session[:category_id] = @category
		@subcategories = ChemSubcat.where(chem_cat: @category)
		json_message = {:chemical => @chemical, :category => @category, :subcategories => @subcategories}
		render json: json_message
	end
	def confirm
		session[:confirmed] = true
		env["HTTP_REFERER"] += '#categorize_chemical'
		redirect_to "/categories/new"
	end
	def create
		# params[:subcat] is an array containing all the subcategories

		subcats = params[:subcat]
		if subcats
			subcats.each do |cat|  
				ship = ChemCatShip.find_by(chemical: Chemical.find(session[:chemical_id]), chem_cat: ChemCat.find(session[:category_id]), chem_subcat: ChemSubcat.find(cat)) 
				if !ship
					ChemCatShip.create(chemical: Chemical.find(session[:chemical_id]), chem_cat: ChemCat.find(session[:category_id]), chem_subcat: ChemSubcat.find(cat)) 
				end
			end
		end
		# ItemChemShip.where(chemical: Chemical.find(session[:chemical_id]), item: Item.find(session[:item_id])).update_all(percentage: params[:percentage])
		# session[:confirmed] = nil
		session[:categorized] = true
		session[:flash] = ["Your categories were added successfully"]
		env["HTTP_REFERER"] += '#added_chemicals'
		redirect_to :back
	end
	def new
		@admin = Admin.find(session[:admin_id])
		@currentItem = Item.find(session[:item_id])
		@currentChemical = Chemical.find(session[:chemical_id])
		@categories = ChemCat.all
		@addedChemicals = ItemChemShip.joins(:chemical).select("chemicals.name, chemicals.id").where(item: Item.find(session[:item_id]))
	end
end
