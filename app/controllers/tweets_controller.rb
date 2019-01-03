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
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
         @tweet = Tweet.find(params[:id])
         if @tweet.user_id == current_user.id
            erb :"tweets/edit_tweet"
         else
            puts "You can only edit your tweet"
            redirect "/tweets"
         end
      else
         redirect "/login"
      end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if @tweet && params[:content].length > 0
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
      redirect "/tweets/#{@tweet.id}/edit"
   end

   delete '/tweets/:id/delete' do
      if logged_in?
         @tweet = Tweet.find(params[:id])
         if @tweet.user_id == current_user.id
            @tweet.delete
            redirect "/tweets"
         else
            puts "You can`t delete others tweets"
            redirect "/tweets"
         end
      else
         redirect "/login"
      end
   end


end
