require_relative '../book'
require_relative '../rental'
require_relative '../student'

describe 'Unit Test of book' do
  before(:each) do
    @book = Book.new('The Hobbit', 'J.R.R. Tolkien')
  end

  it 'should return the title of the book' do
    expect(@book.title).to eql('The Hobbit')
  end

  it 'should return the author of the book' do
    expect(@book.author).to eql('J.R.R. Tolkien')
  end

  it 'check the be_instance_of book' do
    expect(@book).to be_instance_of(Book)
  end

  it 'should return the rental book' do
    person = Student.new(18, 'Class A', 'John Doe')
    rental = Rental.new('2020-01-01', @book, person)
    expect(@book.rentals).to eql([rental])
  end
end
