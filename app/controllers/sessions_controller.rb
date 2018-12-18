class SessionsController < ApplicationController

  get '/login' do
    if !logged_in?
      erb :"/sessions/login"
    else
     redirect '/tweets'
    end
  end

  post '/login' do
    # binding.pry
    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/index"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    logout!
    redirect '/tweets'
  end



end
