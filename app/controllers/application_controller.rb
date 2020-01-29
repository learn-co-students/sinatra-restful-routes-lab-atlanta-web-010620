class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # show all 
  get '/recipes' do 
    @recipes = Recipe.all 
    erb :index 
  end 

  # create new recipe 
  get '/recipes/new' do 
    erb :new 
  end 

  post '/recipes' do 
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end 

  # display by id 
  get '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    erb :show 
  end 

  # delete recipe 
  delete '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete 
    redirect to '/recipes'
  end 

  # edit recipe 
  # load edit form 
  get '/recipes/:id/edit' do 
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit 
  end 

  # edit the instance 
  patch '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save 
    redirect to "/recipes/#{@recipe.id}"
  end 

end
