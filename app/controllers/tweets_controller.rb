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
      if post = current_user.posts.find_by(params[:id])
      "An edit tweet form"
      else
        redirect '/tweets'
    end
  end


end
