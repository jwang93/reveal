ProjectDa::Application.routes.draw do

  resources :users
  resources :project

  get '/' => 'project#home'
  get '/get-info' => 'project#get_degrees'
  get '/get_academic' => 'project#get_academic'
  post '/prereqs' => 'project#get_academic'
  post '/core' => 'project#core'
  post '/extra_curric' => 'project#get_ec'
  post '/electives' => 'project#electives'
  post '/results' => 'project#results'
  get '/get-major' => 'project#checkbox'
  post '/post-results' => 'project#results'
  get '/add_degree' => 'degrees#add'
  post '/degree_add_success' => 'degrees#success'
  get '/test' => 'project#test'
  
end
