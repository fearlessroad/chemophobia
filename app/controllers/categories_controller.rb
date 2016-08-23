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
		redirect_to :back
	end
	def create
		subcats = params[:subcat]
		if subcats
			subcats.each do |cat| 
				ChemCatShip.create(chemical: Chemical.find(session[:chemical_id]), chem_cat: ChemCat.find(session[:category_id]), chem_subcat: ChemSubcat.find(cat))
			end
		end
		ItemChemShip.where(chemical: Chemical.find(session[:chemical_id]), item: Item.find(session[:item_id])).update_all(percentage: params[:percentage])
		env["HTTP_REFERER"] += '#added_chemicals'
		redirect_to :back
	end
end
