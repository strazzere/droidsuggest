#! /usr/bin/env ruby
require 'rubygems'
require 'droidsuggest'

api = DroidSuggest::API.new
puts 'Attempting to look for suggestions for \'look\'...'
suggestions = api.suggest("look")
puts 'Found ' + suggestions.length.to_s + ' suggestions!'
suggestions.each do |suggestion|
  puts 'Suggestion ' + suggestion[:position].to_s + ' : ' + suggestion[:suggestion] + ' suggestion type was ' + suggestion[:suggestion_type]
  if(suggestion[:suggestion_type] == 'APPLICATION')
    puts 'Icon url for suggestion : ' + suggestion[:icon_url]
    puts 'Package name for suggesiton : ' + suggestion[:package_name]
  end
end
