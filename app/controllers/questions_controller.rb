get '/questions' do
  @questions = Question.all
  erb :'/questions/index'
end

get '/questions/new' do
  erb :'/questions/new'
  # <input type="hidden" name="question[user_id]" value="<%= current_user.id %>">
end

post '/questions' do
  question = Question.new(params[:question])
  if question.save
    redirect '/questions'
  else
    @errors = question.errors.full_messages
    erb :'/questions/new'
  end
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  erb :'/questions/show'
end

post "/questions/:question_id/answers/new" do
  answer = Answer.new(params[:answer])
  if answer.save
    redirect "/questions/#{params[:answer][:question_id]}"
  else
    # if a current user, show errors
    # else redirect to login
    @question = Question.find(params[:answer][:question_id])
    @errors = answer.errors.full_messages
    erb :'/questions/show'
  end
end

get '/questions/:id/edit' do
  @question = Question.find(params[:id])
  erb :'/questions/edit'
end

put '/questions/:id' do
  @question = Question.find(params[:id])
  @question.assign_attributes(params[:question])

  if question.save
    redirect "/questions/#{@question.id}"
  else
    @errors = question.errors.full_messages
    erb :'/questions/edit'
  end
end