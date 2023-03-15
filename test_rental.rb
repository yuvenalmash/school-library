require_relative './teacher'
require_relative './student'
require_relative './rental'
require_relative './book'

book = Book.new('The Hobbit', 'J.R.R. Tolkien')
person = Student.new(18, 'Class A', 'John Doe')
rental = Rental.new('2020-01-01', book, person)
puts rental.person.name

describe 'Unit Test of rental' do
  before(:each) do
    @book = Book.new('The Hobbit', 'J.R.R. Tolkien')
    @person = Student.new(18, 'Class A', 'John Doe')
    @rental = Rental.new('2020-01-01', @book, @person)
  end

  it 'should return the date of the rental' do
    expect(@rental.date).to eql('2020-01-01')
  end
  it 'check the be_instance_of rental' do
    expect(@rental).to be_instance_of(Rental)
  end
end
