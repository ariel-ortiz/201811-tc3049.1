require 'sinatra'
require 'json'
require 'sequel'

PORT = 8082
DB = Sequel.connect('sqlite://scores.db')
SCORES = DB[:scores]

configure do
  set :bind, '0.0.0.0'
  set :port, PORT
end

before do
  content_type :json
end

not_found do
  {"error" => "Resource not found: #{ request.path_info }"}.to_json
end

def parse_body(str)
  begin
    data = JSON.parse(str)
    return data if data['initials'] and data['score']
  rescue JSON::ParserError
    # pass
  end
  nil
end

post '/scores' do
  data = parse_body(request.body.read)
  if data
    data['timestamp'] = Time.now
    SCORES << data
    [201, {:message => 'New resource was created successfully.'}.to_json]
  else
    [400, {'error' => 'Invalid input.'}.to_json]
  end
end

get '/scores' do
  JSON.pretty_generate(
    SCORES.order(Sequel.desc(:score), :timestamp).map do |score|
      {
        'initials' => score[:initials],
        'score' => score[:score],
        'date' => score[:timestamp]
      }
    end
  )
end
