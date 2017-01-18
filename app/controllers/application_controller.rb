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
    erb :'score/new'
  end

  get '/about' do
    erb :'about'
  end

  get '/score/new' do
    erb :'score/new'
  end

  get '/score' do
    q_params = params.symbolize_keys.delete_if {|k,v| v.empty?}
    @user = User.new(**q_params)
    resp = HTTParty.get('http://www.voterfile.nyc/score', query: q_params)
    resp = JSON.parse(resp, symbolize_names: true)
    if resp[:success]
      @score = Score.new(resp[:body][:voter])
      @averages = Score.new(resp[:body][:averages])
      @user.firstname = resp[:body][:voter][:firstname]
      @user.lastname = resp[:body][:voter][:lastname]
      @user.dob = resp[:body][:voter][:firstname]
      erb :'score/index'
    else
      flash[:error] = "Voter Record Not Found"
      erb :'/score/new'
    end
  end

end
