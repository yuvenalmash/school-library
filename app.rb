require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require 'json'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
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

  def Store_books
    file = File.read('./books.json')
    books = JSON.parse(file)
    books.each do |book|
      @books << Book.new(book['title'], book['author'])
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

  def save
    convert_book = @books.map do |book|
      {
        title: book.title,
        author: book.author
      }
    end
    file = File.open('./books.json', 'w')
      books = JSON.dump(convert_book)
      file.puts(books)
      file.close
  end
end
