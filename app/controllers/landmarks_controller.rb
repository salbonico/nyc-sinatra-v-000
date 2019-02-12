class LandmarksController < ApplicationController
  # add controller methods

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  post 'landmarks' do
    newlandmark = Landmark.create(:name => params["landmark"]["name"], :year_completed => params["landmark"]["year_completed"], :figure_id => params["landmark"]["figure_id"])
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

    end
  id = newfigure.id
  redirect "/figures/#{id}"
  end


end
