require 'net/http'
require 'json'
 
URL_MICROSERVICE_QUESTIONS = 'http://localhost:8081/questions'
URL_MICROSERVICE_SCORES = 'http://localhost:8082/scores'
 
# From “Code example of using REST in Ruby on Rails” by LEEjava
# https://leejava.wordpress.com/2009/04/10/code-example-to-use-rest-in-ruby-on-rails/
#
module RESTful
   
  def self.get(url)
    uri = URI.parse(url)
    http = Net::HTTP.start(uri.host, uri.port)
    resp = http.send_request('GET', uri.request_uri)
    resp.body
  end
 
  def self.post(url, data, content_type)
    uri = URI.parse(url)
    http = Net::HTTP.start(uri.host, uri.port)
    http.send_request('POST', uri.request_uri, data, 'Content-Type' => content_type)
  end
 
  def self.put(url, data, content_type)
    uri = URI.parse(url)
    http = Net::HTTP.start(uri.host, uri.port)
    http.send_request('PUT', uri.request_uri, data, 'Content-Type' => content_type)
  end
 
  def self.delete(url)
    uri = URI.parse(url)
    http = Net::HTTP.start(uri.host, uri.port)
    http.send_request('DELETE', uri.request_uri)
  end
end
 
def process_options(question)
  answer = question['answer']
  options = question['options'].map.with_index do |text, i|
    { :text => text, :is_correct => i == answer }
  end
  options.shuffle!
  options.zip('A'..'Z').each {|option, letter| option[:letter] = letter}
  puts
  puts "Options: "
  options.each do |option|
    if option[:is_correct] then answer = option[:letter] end
    puts "  #{ option[:letter] }) #{ option[:text] }"
  end
  puts
  answer  
end
 
def ask_questions(n)
  puts 'Welcome to the SOLID quiz.'
  puts
  questions = JSON.parse(RESTful.get(URL_MICROSERVICE_QUESTIONS))
  questions.shuffle!
  questions = questions[0...n]
  num_question = 1
  num_correct = 0
  questions.each do |q|
    puts "Question #{ num_question }/#{ n }"
    question = JSON.parse(RESTful.get("#{ URL_MICROSERVICE_QUESTIONS }/#{ q['id'] }"))
    puts question['question']
    answer = process_options(question)
    print 'Please type your answer: '
    option = gets.chomp
    puts
    if option.upcase == answer
      puts 'Correct!'
      num_correct += 1
    else
      puts "Wrong! The correct answer was: #{ answer }."
    end
    puts
    num_question += 1
  end
  score = ((num_correct.to_f / questions.size) * 100).to_i
  puts "Your score: #{ score }%"
  puts
  if score > 0
    print 'Type you initials: '
    initials = gets.chomp
    puts
    RESTful.post(URL_MICROSERVICE_SCORES, 
      {'initials' => initials, 'score' => score}.to_json, 
      'application/json')
  end
  scores = JSON.parse(RESTful.get(URL_MICROSERVICE_SCORES))
  puts 'SCORE TABLE'
  puts '--------- ----- -------------------------'
  puts 'User      Score Date'
  puts '--------- ----- -------------------------'
  scores.each do |s|
    puts '%-10s  %3d %s' % [s['initials'], s['score'], s['date']]
  end
  puts '--------- ----- -------------------------'
end
 
ask_questions(3)
