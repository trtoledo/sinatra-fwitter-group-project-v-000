class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if  logged_in?
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    # if !params[:content].empty?
    if !params[:content].blank?
      @tweet = Tweet.new(:content => params[:content])
      @tweet.save
      @user = current_user
      @user.tweets << @tweet
      @user.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_slug(params[:slug])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    if  !logged_in?
      redirect "/login"
    else
      if post = current_user.posts.find_by(params[:id])
      erb :"tweets/edit_tweet"
      else
        redirect '/tweets'
      end
    end
  end


end
