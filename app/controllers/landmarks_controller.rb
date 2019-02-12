class LandmarksController < ApplicationController
  # add controller methods

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  post '/landmarks' do
    newlandmark = Landmark.create(:name => params["landmark"]["name"], :year_completed => params["landmark"]["year_completed"], :figure_id => params["landmark"]["figure_id"])
    if params["figure"]["name"] != ""
      if Figure.find{|figure| figure.name == params["figure"]["name"]}
          figureinput = Figure.find{|figure| figure.name == params["figure"]["name"]}
          newlandmark.figure_id = figureinput.id
          newlandmark.save
      else
          tempfigure = Figure.create(:name => params["figure"]["name"])
          newlandmark.figure_id = tempfigure.id
          newlandmark.save
      end
    end
  id = newlandmark.id
  redirect "/landmarks/#{id}"
  end


  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/edit'
  end


get '/landmarks/:id' do
  @landmark = Landmark.find(params[:id])
  erb :'/landmarks/show'
end

patch '/landmarks/:id' do
  ###bugfix
if !params.keys.include?("genres")
    params[:genre] = []
    end
###/bugfix
newlandmark = Landmark.find(params[:id])
newlandmark.update(:name => params["landmark"]["name"], :year_completed => params["landmark"]["year_completed"], :figure_id => params["landmark"]["figure_id"])
if params["figure"]["name"] != ""
  if Figure.find{|figure| figure.name == params["figure"]["name"]}
      figureinput = Figure.find{|figure| figure.name == params["figure"]["name"]}
      newlandmark.figure_id = figureinput.id
      newlandmark.save
  else
      tempfigure = Figure.create(:name => params["figure"]["name"])
      newlandmark.figure_id = tempfigure.id
      newlandmark.save
  end
end
id = newlandmark.id
redirect "/landmarks/#{id}"

end

end
