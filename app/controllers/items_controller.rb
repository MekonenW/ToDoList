class ItemsController < ApplicationController
	before_action :find_item, only: [:show, :update, :edit, :destroy, :complete]

	def index
		@items = Item.where(:user_id => current_user).order("created_at DESC")
	end
	def new 
		@item = current_user.items.build
	end 
	def create 
		@item = current_user.items.build(item_params)
		if @item.save
			redirect_to '/'
		else
			flash[:errors]= @item.errors.full_messages
			redirect_to '/items/new'
		end
	end 

	def show 
	end 

	def update 
		if @item.update(item_params)
			redirect_to '/items'
		else
			flash[:errors]= @item.errors.full_messages
			redirect_to '/items/new'
		end
	end

	def edit 
	end

	def destroy
	@item= Item.find(params[:id])
	@item.destroy
	redirect_to '/items'
	end

	def complete
		@item= Item.find(params[:id])
		@item.update_attribute(:completed_at, Time.now)
		redirect_to '/'
	end 


	private 
		def item_params
			params.require(:item).permit(:title, :description)
		end 
		def find_item
			@item = Item.find(params[:id])
		end

	 
		
end
