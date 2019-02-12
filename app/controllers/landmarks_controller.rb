class LandmarksController < ApplicationController
  # add controller methods

  get '/landmarks' do
    @landmarkss = Landmark.all
    erb :'/landmarks/index'
  end
end
