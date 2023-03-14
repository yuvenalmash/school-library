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
end
