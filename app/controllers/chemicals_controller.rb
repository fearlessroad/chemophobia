class ChemicalsController < ApplicationController
	def new
		@chemicals = Chemical.all
	  	@categories = ChemCat.all
	  	@subcategories = ChemSubcat.all
	  	@admin = Admin.find(session[:admin_id])
	  	@currentItem = Item.find(session[:item_id])
	  	@addedChemicals = ItemChemShip.joins(:chemical).select("chemicals.name, chemicals.id").where(item: Item.find(session[:item_id]))
	  	if session[:chemical_id]
	  		@currentChemical = Chemical.find(session[:chemical_id])
	  	end
	  	if !session[:item_id]
	  		redirect_to 'items/new'
	  	end
	end
	def create
		if params[:chemicalSelected] == ""
			chemical = Chemical.find_by(name: params[:chemicalWritten])
			if chemical 
				session[:chemical_id] = chemical.id
				ItemChemShip.create(item: Item.find(session[:item_id]), chemical: Chemical.find(chemical.id))
				# redirect_to :back
					json_message = {:status => 'success', :message => chemical.name+' was successfully added!'}
					render json: json_message
			else
				chemical = Chemical.new(name: params[:chemicalWritten], iupac: params[:iupac], formula: params[:formula], image:params[:image], description: params[:description], ld50: params[:ld50], origin: params[:origin])

				if chemical.save
					ItemChemShip.create(item: Item.find(session[:item_id]), chemical: Chemical.find(chemical.id))
					session[:chemical_id] = chemical.id 
					# redirect_to :back
					json_message = {:status => 'success', :message => chemical.name+' was successfully added!'}
					render json: json_message
				else 
					# redirect_to :back
					json_message = {:status => 'failure', :message => chemical.errors.full_messages}
					render json: json_message
				end
			end
		else 
			chemical = Chemical.find(params[:chemicalSelected])
			ItemChemShip.create(item: Item.find(session[:item_id]), chemical: chemical)
			session[:chemical_id] = chemical.id
			# redirect_to :back
			json_message = {:status => 'success', :message => chemical.name+' was successfully added!'}
			render json: json_message
		end
	end
	def update
		chemical = Chemical.find(session[:chemical_id])
		if chemical.update(chemical_params)
			flash[:success] = ["you have successfully updated this chemical"]
		else 
			flash[:errors] = chemical.errors.full_messages
		end
		redirect_to :back

	end
	def resetSession
		session[:chemical_id] = nil
		session[:category_id] = nil
		session[:confirmed] = nil
		session[:categorized] = nil
		redirect_to :back
	end
	def getInfo
		@chemical = Chemical.find(params[:id])
		@categories = ChemCatShip.joins(:chem_cat).joins(:chem_subcat).select("chem_cats.name as cat_name, chem_cats.id as cat_id, chem_subcats.name as subcat_name, chem_subcats.id as subcat_id").where(chemical: @chemical)
		msg = {:chemical => @chemical, :categories => @categories}
		render json: msg
	end
private
	def chemical_params
		params.required(:chemical).permit(:name, :description, :image, :ld50, :formula, :iupac, :origin)
	end
end
