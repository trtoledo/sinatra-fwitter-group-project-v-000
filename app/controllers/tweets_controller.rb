class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :"/tweets/tweets"
  end

  get '/tweets/new' do
    if  !logged_in?
      redirect "/login"
    else
      erb :"/tweets/new"
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:content])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
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


end
