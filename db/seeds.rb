# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Ted = User.create!(email: 'ted@example.com', sms_number: '5551231234', password: '1234', password_confirmation: '1234')
Ted.alerts.create!(name: 'snoop' , email_enabled: true, sms_enabled: false, feed_username: 'snoopdoggnotreal')
Ted.alerts.first.keywords.create!(phrase: 'tickets')

Linda = User.create!(email: 'linda@linda.com', sms_number: '2065551234', password: 'password', password_confirmation: 'password')
Linda.alerts.create!(name: 'comicon' , email_enabled: true, sms_enabled: true, feed_username: 'comiconfake')
Linda.alerts.first.keywords.create!(phrase: 'on sale')
Linda.alerts.first.keywords.create!(phrase: 'coming soon')