# Populate languages
Language.create(name: 'English', local: 'English', acronym: 'gb')
Language.create(name: 'French', local: 'Français', acronym: 'fr')
Language.create(name: 'German', local: 'Deutsch', acronym: 'de')
Language.create(name: 'Luxembourgish', local: 'Lëtzebuergesch', acronym: 'lu')
Language.create(name: 'Spanish', local: 'Español', acronym: 'es')
Language.create(name: 'Portuguese', local: 'Português', acronym: 'pt')
Language.create(name: 'Italian', local: 'Italiano', acronym: 'de')
Language.create(name: 'Dutch', local: 'Nederlands', acronym: 'nl')
Language.create(name: 'Swedish', local: 'Svenska', acronym: 'se')

# Populate categories
Category.create(name: 'Book', description: 'Bicher')
Category.create(name: 'eBook', description: 'Kindle, etc.')
Category.create(name: 'Map', description: 'Landkaarten, etc.')
Category.create(name: 'Audiobook', description: 'Hörbücher, etc.')
Category.create(name: 'ePUB/PDF')
Category.create(name: 'Audio CD')
Category.create(name: 'DVD')

# Populate publishers (from JSON file)
publishers = ActiveSupport::JSON.decode(File.read('db/publishers.json'))
publishers.each do |publisher|
  Publisher.create(name: publisher['name'], description: publisher['description'], website: publisher['website'])
end

# Populate genres (from JSON file)
genres = ActiveSupport::JSON.decode(File.read('db/genres.json'))
genres.each do |genre|
  Genre.create(name: genre['name'], description: genre['description'])
end

# Populate collections
Collection.create([
                    { name: 'Gold', description: 'Gold Collection' },
                    { name: 'Silver', description: 'Silver Colection' },
                    { name: 'Bronze', description: 'Bronze Colection' },
                  ])

# Populate colors
Color.create([
               { name: 'Red', description: 'Roud Bicher', hex_code: '#ff0000' },
               { name: 'Yellow', description: 'Giel Bicher', hex_code: '#f4c73c' },
               { name: 'Green', description: 'Greng Bicher', hex_code: '#228b22' },
               { name: 'Blue', description: 'Blo Bicher', hex_code: '#0000ff' },
               { name: 'Black', description: 'Schwaarz Bicher', hex_code: '#000000' },
               { name: 'White', description: 'Wäiss Bicher', hex_code: '#ffffff' },
               { name: 'Purple', description: 'Mauve Bicher', hex_code: '#9932cc' },
               { name: 'Rose', description: 'Rosa Bicher', hex_code: '#ff66cc' },
               { name: 'Orange', description: 'Orange Bicher', hex_code: '#ff5500' },
               { name: 'Brown', description: 'Brong Bicher', hex_code: '#a0522d' },
               { name: 'Gray', description: 'Gro Bicher', hex_code: '#a1a1a1' },
               { name: 'Turquoise', description: 'Turquoise Bicher', hex_code: '#34dddd' }
             ])

# Populate users (default password: password)
User.create([
              { name: 'John Smith', email: 'john.smith@bicherwuerm.org', password: 'password', admin: true, encrypted_password: '$2a$10$vZByqNJMfmadnUqHTqKQjuYJtYmGmwDaSfn.V0zjRADPSXQibPYEG' },
              { name: 'Alex Cass', email: 'alex.cass@bicherwuerm.org', password: 'password', admin: false, encrypted_password: '$2a$10$vZByqNJMfmadnUqHTqKQjuYJtYmGmwDaSfn.V0zjRADPSXQibPYEG' }
            ])

# Generate books
25.times do
  Book.create(
    title: Faker::Address.street_name,
    author: Faker::Name.name,
    location: Faker::Address.country,
    user_id: rand(1..User.count),
    publisher_id: rand(1..Publisher.count),
    category_id: rand(1..Category.count),
    language_id: rand(1..Language.count),
    genre_id: rand(1..Genre.count)
  )
end
