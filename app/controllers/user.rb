get '/users/new' do
  erb :'users/new'
end

get '/users/:id' do

end

post '/users' do
  user = User.create(params[:user])
  if user.valid?
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = user.errors.full_messages
    erb :'users/new'
  end
end
