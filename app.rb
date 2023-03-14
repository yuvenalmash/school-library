require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require 'json'

class App
  attr_accessor :people, :books, :rentals

  def initialize(people_raw, books_raw, rentals_raw)
    @people = []
    @books = []
    @rentals = []
    convert_raw_data(people_raw, books_raw, rentals_raw)
  end

  def list_all_books
    puts 'List of all books:'
    @books.each do |book|
      puts "\"#{book.title}\" by #{book.author}"
    end
  end

  def list_all_people
    puts 'List of all people:'
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    input = gets.chomp

    case input
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid input, please try again'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp

    print 'Name: '
    name = gets.chomp

    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.upcase == 'Y'
    classroom = 'Class A'
    student = Student.new(age, classroom, name, parent_permission: parent_permission)
    @people << student
    puts 'Student created successfully'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp

    print 'Name: '
    name = gets.chomp

    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name, parent_permission: true)
    @people << teacher
    puts 'Teacher created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) \"#{book.title}\" by #{book.author}"
    end

    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] #{person.name}"
    end

    person_index = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp

    rental = Rental.new(date, @books[book_index], @people[person_index])
    @rentals << rental
    puts 'Rental created successfully'
  end

  def list_persons_rentals
    list_all_people
    print 'ID of person: '
    id = gets.chomp.to_i

    puts 'Rentals:'
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}" if rental.person.id == id
    end
  end

  def convert_raw_data(people_raw, books_raw, rentals_raw)
    convert_raw_people(people_raw)
    convert_raw_books(books_raw)
    convert_raw_rentals(rentals_raw)
  end

  def convert_raw_people(people_raw)
    people_raw.each do |person|
      person = JSON.parse(person)
      @people << case person['type']
                 when 'Student'
                   Student.new(person['age'], person['classroom'], person['name'],
                               parent_permission: person['parent_permission'])
                 when 'Teacher'
                   Teacher.new(person['age'], person['specialization'], person['name'], parent_permission: true)
                 end
    end
  end

  def convert_raw_books(books_raw)
    books_raw.each do |book|
      book = JSON.parse(book)
      @books << Book.new(book['title'], book['author'])
    end
  end

  def convert_raw_rentals(rentals_raw)
    rentals_raw.each do |rental|
      rental = JSON.parse(rental)
      book = JSON.parse(rental['book'])
      person = JSON.parse(rental['person'])
      book = @books.find { |b| b.title == book['title'] && b.author == book['author'] }
      person = @people.find { |p| p.name == person['name'] && p.age == person['age'] }

      @rentals << Rental.new(rental['date'], book, person)
    end
  end
end
