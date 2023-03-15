require 'json'
require_relative 'app'

class FileManagment
  def read_file(file_name)
    unless File.exist?(file_name)
      File.new(file_name, 'w')
      write_file(file_name, [])
    end

    File.open(file_name, 'r') do |f|
      json_string = f.read
      JSON.parse(json_string)
    end
  end

  def load_from_files
    people = read_file('storage_files/people.json')
    books = read_file('storage_files/books.json')
    rentals = read_file('storage_files/rentals.json')
    [people, books, rentals]
  end

  def write_file(file_name, data)
    File.write(file_name, JSON.generate(data))
  end

  def save_to_files(books_list, people_list, rentals_list)
    save_books_to_files(books_list)
    save_people_to_files(people_list)
    save_rentals_to_files(rentals_list)
  end

  def save_people_to_files(people_list)
    people = []
    people_list.each do |person|
      if person.instance_of?(Student)
        student_hash = { id: person.id, name: person.name, age: person.age,
                         parent_permission: person.parent_permission, classroom: person.classroom, type: 'Student' }
        people.push(JSON.generate(student_hash))
      elsif person.instance_of?(Teacher)
        teacher_hash = { id: person.id, name: person.name, age: person.age, specialization: person.specialization,
                         type: 'Teacher' }
        people.push(JSON.generate(teacher_hash))
      end
    end
    write_file('storage_files/people.json', people)
  end

  def save_books_to_files(books_list)
    books = []
    books_list.each do |book|
      book_hash = { title: book.title, author: book.author }
      books.push(JSON.generate(book_hash))
    end
    write_file('storage_files/books.json', books)
  end

  def save_rentals_to_files(rentals_list)
    rentals = []
    rentals_list.each do |rental|
      book_hash = { title: rental.book.title, author: rental.book.author }
      book = JSON.generate(book_hash)
      person_hash = { id: rental.person.id, name: rental.person.name, age: rental.person.age,
                      rentals: [book_hash, rental.date] }
      person = JSON.generate(person_hash)
      rental_hash = { date: rental.date, book: book, person: person }
      rentals.push(JSON.generate(rental_hash))
    end
    write_file('storage_files/rentals.json', rentals)
  end
end
