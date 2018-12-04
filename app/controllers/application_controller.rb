require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
  end

  get '/' do
    erb :"/index"
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(:email => session[:email]) if session[:email]
    end

    def login(username, email, password)
      user = User.find_by(:email => email)
      if user && user.authenticate(password)
        # session[:user_id] = user.id
        session[:username] = user.username
        session[:email] = user.email
        session[:pasword] = user.password
        redirect "users/#{:id}"
      else
        redirect '/login'
      end
    end

    def logout!
      session.clear
    end


  end

end
