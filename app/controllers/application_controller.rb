require './config/environment'

class ApplicationController < Sinatra::Base
  include Sinatra::SessionHelper
  use Rack::Flash
  configure do
    set :public_folder, '/public'
    set :static, true
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      redirect to :"/score"
    else
      redirect to :"/score/new"
    end
  end

  get '/about' do
    erb :'about'
  end

  get '/score/new' do
    erb :'score/new'
  end

  get '/logout' do
    session.clear
    redirect to "/"
  end

  get '/score' do
    @user = current_user || User.new
    q_params = params.symbolize_keys.delete_if {|k,v| v.empty?}
    @user.assign_attributes(**q_params)
    resp = @user.get_scores
    if resp[:success]
      @score = Score.new(resp[:body][:voter])
      @averages = Score.new(resp[:body][:averages])
      user_params = resp[:body][:voter].symbolize_keys.delete_if {|k,v| v.empty?}
      @user.firstname = user_params[:firstname]
      @user.lastname = user_params[:lastname]
      @user.dob = user_params[:dob]
      @user.sboeid = user_params[:sboeid]
      erb :'score/index'
    else
      flash[:error] = "Voter Record Not Found"
      erb :'/score/new'
    end
  end

  get '/users/new' do
    q_params = params.symbolize_keys.delete_if {|k,v| v.empty?}
    @user = User.new(**q_params)
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect to "/score"
    else
      flash[:error] = "Failed to create new user"
      redirect to '/users/new'
    end
  end


end
