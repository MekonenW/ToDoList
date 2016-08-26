Rails.application.routes.draw do
	devise_for :users
	root 'items#index'
	resources :items do 
		member do 
			patch :complete
		end
	end

end
