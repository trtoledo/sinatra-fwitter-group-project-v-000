class TweetsController < ApplicationController

  get '/tweets' do
    "list all tweets"
  end

  get '/tweets/new' do
    if  !logged_in?
      redirect "/login"
    else
      "A new tweet form"
    end
  end

  get '/tweets/:id/edit' do
    if  !logged_in?
      redirect "/login"
    else
      "An edit tweet form"
    end
  end


end
