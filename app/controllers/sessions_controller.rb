class SessionsController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/sessions/login"
    end
  end

  post '/login' do
    # binding.pry
    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      logout!
    else
    redirect '/login'
    end
  end



end
