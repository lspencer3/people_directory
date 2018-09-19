Rails.application.routes.draw do
	get 'welcome/index'

	devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

	namespace :api, defaults: { format: "json" } do

	    get :me, to: 'me#me'
	end

	root to: "main#index"

	get '/base/process_records' => 'base#process_records'

	get '/count' => 'count#count_letters'

	get '/findup' => 'duplicates#find_possible_dups'

	#get '/base/count_letters' => 'base#count_letters'

	get '/base/find_possible_dups' => 'base#find_possible_dups'
end
