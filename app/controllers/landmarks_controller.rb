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
    newlandmark = Landmark.create(:name => params["landmark"]["name"], :year_completed => params["landmark"]["year_completed"], :figure_id => params["figure"]["landmark_ids"])
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


end
