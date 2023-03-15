require 'json'
require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'

module FileManagment
  def self.save_to_files(books, people, rentals)
    save_books_to_files(books)
    save_people_to_files(people)
    save_rentals_to_files(rentals)
  end

  def self.save_books_to_files(books)
    books_json = books.map do |book|
      {
        'title' => book.title,
        'author' => book.author
      }
    end
    File.write('storage_files/books.json', JSON.generate(books_json))
  end

  def self.save_people_to_files(people)
    people_json = people.map do |person|
      if person.class == Student
        {
          'id' => person.id,
          'name' => person.name,
          'age' => person.age,
          'classroom' => person.classroom,
          'parent_permission' => person.parent_permission,
          'type' => person.class.to_s
        }
      elsif person.class == Teacher
        {
          'id' => person.id,
          'name' => person.name,
          'age' => person.age,
          'specialization' => person.specialization,
          'parent_permission' => person.parent_permission,
          'type' => person.class.to_s
        }
      end
    end
    File.write('storage_files/people.json', JSON.generate(people_json))
  end

  def self.save_rentals_to_files(rentals)
    rentals_json = rentals.map do |rental|
      {
        'date' => rental.date,
        'book' => {
          'title' => rental.book.title,
          'author' => rental.book.author
        },
        'person' => {
          'id' => rental.person.id,
          'name' => rental.person.name,
          'age' => rental.person.age
        }
      }
    end
    File.write('storage_files/rentals.json', JSON.generate(rentals_json))
  end

  def self.load_from_files
    books = load_books_from_files('storage_files/books.json')
    people = load_people_from_files('storage_files/people.json')
    rentals = load_rentals_from_files(people, books, 'storage_files/rentals.json')
    [books, people, rentals]
  end

  def self.load_books_from_files(file_name)
    if_file_exists?(file_name)
    books_json = File.read(file_name)
    books = JSON.parse(books_json)
    books.map do |book|
      Book.new(book['title'], book['author'])
    end
  end

  def self.load_people_from_files(file_name)
    if_file_exists?(file_name)
    people_json = File.read(file_name)
    people = JSON.parse(people_json)
    people.map do |person|
      if person['type'] == 'Student'
        Student.new(person['age'], person['classroom'], person['name'], parent_permission: person['parent_permission'])
      elsif person['type'] == 'Teacher'
        Teacher.new(person['age'], person['specialization'], person['name'])
      end
    end
  end

  def self.load_rentals_from_files(people,books,file_name)
    if_file_exists?(file_name)
    rentals_json = File.read(file_name)
    rentals = JSON.parse(rentals_json)
    rentals.map do |rental|
      rental['person'] = people.find { |p| p.name == rental['person']['name'] && p.age == rental['person']['age'] }
      rental['book'] = books.find { |b| b.title == rental['book']['title'] && b.author == rental['book']['author'] }
      Rental.new(rental['date'], rental['book'], rental['person'])
    end
  end

  def self.if_file_exists?(file_name)
    unless File.exist?(file_name)
      File.new(file_name, 'w')
      File.write(file_name, [])
    end
  end
end
