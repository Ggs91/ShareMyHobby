require 'csv'
require 'faker'
require 'activerecord-reset-pk-sequence'

Department.destroy_all
Department.reset_pk_sequence

### Department seed ##
csv_text = File.read(Rails.root.join('lib', 'seeds', 'departments_names.csv'))
csv = CSV.parse(csv_text, :encoding => 'ISO-8859-1')

csv.each do |row|
  d = Department.create!(name: row[0])
end
puts "#{Department.all.count} departments created"

### Category seed ###

categories = ["Sport", "Art", "Music", "Cooking", "Science", "Animals"]

Category.create!(
  name: categories.sample
)
puts "#{Category.all.count} categories created"

### User seed ###

d = Department.all.sample(4)

20.times do
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	user = User.create!(
		first_name: first_name,
		last_name: last_name,
    age: Faker::Number.between(15, 50),
		email: first_name + last_name + "@yopmail.com",
		password: "azerty",
    description: Faker::Lorem.paragraph(2, false, 4),
    department: d.sample
	)
end
puts "#{User.all.count} users created"

10.times do |i|
  e = Event.create!(
    title: "Event #{i+1}",
    description: Faker::Lorem.sentence(10),
    location: Faker::TvShows::Friends.location,
    department: d.sample
    start_date: DateTime.new(2019,07,rand(15..30)),
    duration: rand(4..12)*5,
    administrator: User.all.sample
    category: Category.sample
  )
  e.participants.concat(User.all.sample(4))
end
