require_relative 'file_management'
require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'

class App
  include FileManagment
  attr_accessor :books, :people, :rentals

  def initialize()
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    puts 'List of books:'
    @books.each do |book|
      puts "\"#{book.title}\" by #{book.author}"
    end
  end

  def list_all_people
    puts 'List of people:'
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]'
    person_type = gets.chomp
    if person_type == '1'
      create_student
    elsif person_type == '2'
      create_teacher
    else
      puts 'Invalid option, please try again'
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
    puts 'Person created successfully'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    @people << teacher
    puts 'Person created successfully'
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
      puts "#{index}) Title: '#{book.title}', Author: #{book.author}"
    end
    book_index = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] #{person.name}"
    end
    person_index = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp.to_s
    rental = Rental.new(date, @books[book_index], @people[person_index])
    @rentals << rental
    puts 'Rental created successfully'
  end


  def list_all_rentals_for_person_id
    list_all_people
    print 'ID of person: '
    id = gets.chomp.to_i
    rentals = @rentals.filter { |rental| rental.person.id == id }
    puts 'Rentals:'
    rentals.each do |rental|
      puts "Date: #{rental.date}, Book: '#{rental.book.title}' by #{rental.book.author}"
    end
  end

  def save_data
    FileManagment.save_to_files(@books, @people, @rentals)
  end

  def load_data
    data = FileManagment.load_from_files
    @books = data[0]
    @people = data[1]
    @rentals = data[2]
  end
end
