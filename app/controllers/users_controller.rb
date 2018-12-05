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
    if params[:username].blank? || params[:password].blank? || params[:email].blank?
      redirect '/signup'
    else
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
      session[:user_id] = @user.id #login
      redirect '/tweets'
    end



#     @user = User.new(:username =>params[:username], :email =>params[:email], :password =>params[:password])
#     if !@user.username.empty? && !@user.email.empty? && @user.save
#          session[:user_id] = @user.id
#       redirect "/tweets"
#     else
#       redirect "/signup"
#     end


  end


  get 'users/:id' do
    @user = User.find_by(id: params[:id])
    erb :"users/show"
  end


end
