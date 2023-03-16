require_relative '../person'
require_relative '../rental'
require_relative '../book'

describe 'Unit Test of person' do
  before(:each) do
    @person = Person.new(25, 'John Doe')
  end

  it 'should return the name of the person' do
    expect(@person.name).to eql('John Doe')
  end

  it 'should return the age of the person' do
    expect(@person.age).to eql(25)
  end

  it 'should return the name of the person' do
    expect(@person.name).to eql('John Doe')
  end

  it 'should return the correct name' do
    expect(@person.correct_name).to eql('John Doe')
  end

  it 'should return the can use servces' do
    expect(@person.can_use_services?).to eql(true)
  end

  it 'should return the parent_permission of the person' do
    expect(@person.parent_permission).to eql(true)
  end

  it 'should return true if of_age and parent_permission' do
    expect(@person.can_use_services?).to eql(true)
  end

  it 'should return false if not of_age and parent_permission' do
    @person = Person.new(15, 'John Doe', parent_permission: false)
    expect(@person.can_use_services?).to eql(false)
  end

  it 'check the be_instance_of person' do
    expect(@person).to be_instance_of(Person)
  end

  it 'should return the correct name' do
    expect(@person.correct_name).to eql('John Doe')
  end

  it 'should return the rental book' do
    book = Book.new('The Hobbit', 'J.R.R. Tolkien')
    rental = Rental.new('2020-01-01', book, @person)
    expect(@person.rentals).to eql([rental])
  end

  it 'should return an an error for private method' do
    expect { @person.of_age? }.to raise_error(NoMethodError)
  end
end
