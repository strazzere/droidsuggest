#! /usr/bin/env ruby
require 'rubygems'
require 'droidsuggest'

api = DroidSuggest::API.new
puts 'Attempting to look for suggestions for \'look\'...'
suggestions = api.suggest("look")
puts 'Found ' + suggestions.length.to_s + ' suggestions!'
suggestions.each do |placement, suggestion|
  puts 'Suggestion ' + placement.to_s + ' : ' + suggestion
end
