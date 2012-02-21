#! /usr/bin/env ruby
require 'rubygems'
require 'droidsuggest'

api = DroidSuggest::API.new

puts api.suggest("look")
