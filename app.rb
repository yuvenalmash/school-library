require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  # def run
  #   puts 'Welcome to School Library App!'

  #   loop do
  #     home_page
  #   end
  # end

  # def home_page
  #   puts [
  #     '',
  #     'Please choose an option by entering a number:',
  #     '1 - List all books',
  #     '2 - List all people',
  #     '3 - Create a person',
  #     '4 - Create a book',
  #     '5 - Create a rental',
  #     '6 - List all rentals for a given person\'s id',
  #     '7 - Exit',
  #     ''
  #   ]
  #   print 'Enter your choice: '
  #   input = gets.chomp
  #   close if input == '7'
  #   home_page_selection(input)
  # end

  def home_page_selection(input)
    case input
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_persons_rentals
    else
      puts 'Invalid input, please try again'
    end
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

  def close
    puts 'Are you sure you want to exit? [Y/N]'
    input = gets.chomp.upcase
    if input == 'Y'
      puts 'Thank you for using this app!'
      exit
    else
      home_page
    end
  end
end
