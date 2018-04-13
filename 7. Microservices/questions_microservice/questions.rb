require 'yaml'
require 'sinatra'
require 'json'

PORT = 8081
URL = "http://localhost:#{ PORT }/"

questions = YAML.load_file('questions.yml')

configure do
  set :bind, '0.0.0.0'
  set :port, PORT
end

before do
  content_type :json
end

get '/questions' do
  JSON.pretty_generate(questions.map.with_index do |q, i|
    {
      'id' => i,
      'answer' => q['options'][q['answer']],
      'url' => "#{ URL }questions/#{ i }"
    }
  end)
end
