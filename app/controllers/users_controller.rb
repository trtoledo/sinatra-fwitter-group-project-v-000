class UsersController < ApplicationController
  get '/signup' do
    if  logged_in?
      redirect "/tweets"
    else
    erb :"users/create_user"
    end
  end

  post '/signup' do
    # binding.pry
    # @user = User.new(params)
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id #login

      redirect '/tweets'
    else
      redirect '/signup'
    end

  end


  get 'users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end



end
