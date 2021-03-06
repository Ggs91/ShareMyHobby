require 'csv'
require 'faker'
require 'activerecord-reset-pk-sequence'

Participation.destroy_all
Event.destroy_all
Category.destroy_all
Department.destroy_all
User.destroy_all



Participation.destroy_all
Department.reset_pk_sequence
Category.reset_pk_sequence
User.reset_pk_sequence
Event.reset_pk_sequence

### Department seed (from csv scrapped file in lib/seeds)###
csv_text = File.read(Rails.root.join('lib', 'seeds', 'departments_names.csv'))
csv = CSV.parse(csv_text, :encoding => 'ISO-8859-1')

csv.each do |row|
  d = Department.create!(name: row[0])
end
puts "#{Department.all.count} departments created"

### Category seed ###

categories = ["Sport", "Art", "Music", "Cooking", "Science", "Animals","Programmation", "Photography", "Video Making & Editing"]
categories.each do |category|
  Category.create!(
    name: category
  )
end
puts "#{Category.all.count} categories created"

### User seed ###

d = Department.all.sample(4)

20.times do
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	user = User.create!(
		first_name: first_name,
		last_name: last_name,
    date_of_birth: Faker::Date.between(Date.new(1930, 01, 01), Date.today),
		email: first_name + last_name + "@yopmail.com",
		password: "azerty",
    phone_number: "06.23.45.67.89",
    description: Faker::Lorem.paragraph(2, false, 4),
    department: d.sample
	)
end
puts "#{User.all.count} users created"

### Event seed ###
10.times do |i|
  e = Event.create!(
    title: "Event #{i+1}",
    description: Faker::Lorem.sentence(10),
    location: Faker::TvShows::Friends.location,
    department: d.sample,
    start_date: DateTime.new(2019,07,rand(15..30)),
    duration: rand(4..12)*5,
    administrator: User.all.sample,
    category: Category.all.sample,
    max_participants: 10
  )
  e.participants.concat(User.all.sample(4))
end
puts "#{Event.all.count} events created"
puts "End of seeds"
