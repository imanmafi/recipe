require("bundler/setup")
require("pry")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get "/" do
  @recipes = Recipe.all
  @categories = Category.all
  erb(:index)
end

post('/index') do
  @recipes = Recipe.all
  @categories = Category.all
  recipe_name = params.fetch("recipe_name")
  recipe = Recipe.create({:name => recipe_name})
  category_name = params.fetch("category_name")
  Category.create({name: category_name, recipes: [recipe]})
  erb(:index)
end

get('/recipe/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i)
  erb(:recipe)
end

patch "/recipe/:id/rating" do
  rating = params.fetch("rating")
  @recipe = Recipe.find(params.fetch("id").to_i)
  @categories = Category.all
  @recipe.update({:rating => rating})
  erb(:recipe)
end

patch "/recipe/:id" do
  ingredients = params.fetch("ingredients")
  instructions = params.fetch("instructions")
  @categories = Category.all
  @recipe = Recipe.find(params.fetch("id").to_i)
  @recipe.update({:ingredients => ingredients, :instructions => instructions})
  erb(:recipe)
end

delete "/recipe/:id" do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @recipe.destroy
  @recipes = Recipe.all
  @categories = Category.all
  erb(:index)
end

get '/recipe/:id/edit' do
  @recipe = Recipe.find(params.fetch("id").to_i)
  erb(:recipe_edit)
end

patch '/recipe/:id/edit' do
  @recipe = Recipe.find(params.fetch("id").to_i)
  name = params.fetch("name")
  instructions = params.fetch("instructions")
  ingredients = params.fetch("ingredients")
  @recipe.update({name: name, ingredients: ingredients, instructions: instructions})
  erb(:recipe)
end

get "/category/:id" do
  @category = Category.find(params.fetch("id").to_i)
  erb(:category)
end

delete "/category/:id" do
  @category = Category.find(params.fetch("id").to_i)
  @category.destroy
  @recipes = Recipe.all
  @categories = Category.all
  erb(:index)
end