class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    newfigure = Figure.create(:name => params["figure"]["name"], :title_ids => params["figure"]["title_ids"], :landmark_ids => params["figure"]["landmark_ids"])
    if params["title"]["name"] != ""
      if Title.find{|title| title.name == params["title"]["name"]}
          titleinput = Title.find{|title| title.name == params["title"]["name"]}
          newfigure.title_ids = titleinput.id
          newfigure.save
      else
          temptitle = Title.create(:name => params["title"]["name"])
          newfigure.title_ids = temptitle.id
          newfigure.save
      end
    end

    if params["landmark"]["name"] != ""
      if Landmark.find{|landmark| landmark.name == params["landmark"]["name"]}
        landmarkinput = Landmark.find{|landmark| landmark.name == params["landmark"]["name"]}
        newfigure.landmark_ids = landmarkinput.id
        newfigure.save
      else
        templandmark = Landmark.create(:name => params["landmark"]["name"], :year_completed => params["landmark"]["year"])
        newfigure.landmark_ids = templandmark.id
        newfigure.save
      end
    end
  id = newfigure.id
  redirect "/figures/#{id}"
end

patch '/figures/:id' do
  ###bugfix
if !params.keys.include?("genres")
    params[:genre] = []
    end
###/bugfix

newfigure = Figure.find(params[:id])

newfigure.update(:name => params["figure"]["name"], :title_ids => params["figure"]["title_ids"], :landmark_ids => params["figure"]["landmark_ids"])
if params["title"]["name"] != ""
  if Title.find{|title| title.name == params["title"]["name"]}
      titleinput = Title.find{|title| title.name == params["title"]["name"]}
      newfigure.title_ids = titleinput.id
      newfigure.save
  else
      temptitle = Title.create(:name => params["title"]["name"])
      newfigure.title_ids = temptitle.id
      newfigure.save
  end
end

if params["landmark"]["name"] != ""
  if Landmark.find{|landmark| landmark.name == params["landmark"]["name"]}
    landmarkinput = Landmark.find{|landmark| landmark.name == params["landmark"]["name"]}
    newfigure.landmark_ids = landmarkinput.id
    newfigure.save
  else
    templandmark = Landmark.create(:name => params["landmark"]["name"], :year_completed => params["landmark"]["year"])
    newfigure.landmark_ids = templandmark.id
    newfigure.save
  end
end
id = newfigure.id
redirect "/figures/#{id}"
end





get '/figures/:id/edit' do
@figure = Figure.find(params[:id])
erb :'/figures/edit'
end



get '/figures/:id' do
@figure = Figure.find(params[:id])
erb :'/figures/show'
end
end
