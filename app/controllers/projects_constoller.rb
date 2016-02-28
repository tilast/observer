get '/projects' do
  protect!
  @projects = Project.order_by(:name.asc)
  erb :'projects/index'
end

get '/project/new' do
  protect!
  @project = Project.new
  erb :'projects/new'
end

post '/project/new' do
  protect!
  @project = Project.new(
  name: params[:name],
  user_ids: Array(params[:user_ids])
  )
  @project.save

  if @project.valid?
    redirect '/projects'
  else
    erb :'project/new'
  end
end

get '/project/:id' do
  protect!
  @project = Project.find(params[:id])
  erb :'projects/show'
end

get '/project/:id/edit' do
  protect!
  @project = Project.find(params[:id])
  erb :'projects/edit'
end

post '/project/:id' do
  protect!
  @project = Project.find(params[:id])
  @project.update(
    name: params[:name],
    user_ids: Array(params[:user_ids])
  )
  redirect "/project/#{params[:id]}"
end

post '/projects/:id/delete' do
  protect!
  Project.find(params[:id]).delete
  redirect '/projects'
end
