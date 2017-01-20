require './config/environment'

class ApplicationController < Sinatra::Base
  include Sinatra::SessionHelper
  register Sinatra::Sprockets::Helpers

  set :sprockets, Sprockets::Environment.new(root)
  set :assets_prefix, '/assets'
  set :digest_assets, true

  configure do
    set :views, 'app/views'
    set :sessions, true
    set :sessions_secret, "gotv"
    set :public_folder, "assets"
    # Setup Sprockets
    sprockets.append_path File.join(root, 'assets', 'stylesheets')
    sprockets.append_path File.join(root, 'assets', 'javascripts')
    sprockets.append_path File.join(root, 'assets', 'images')

    configure_sprockets_helpers do |helpers|
      helpers.asset_host = "#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com"
    end
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
