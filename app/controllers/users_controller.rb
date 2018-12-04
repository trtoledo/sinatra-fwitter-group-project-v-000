class UsersController < ApplicationController
  get '/signup' do
    if  logged_in?
      redirect "/tweets"
    else
    erb :"users/create_user"
    end
  end

  # get '/users/new' do
  #   erb :"users/create_user"
  # end


  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
    else
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
      session[:id] = @user.id
      redirect '/tweets'
    end
  end

  get 'users/:id' do
    erb :"show"
  end


end
