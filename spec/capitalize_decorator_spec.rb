require_relative '../capitalize_decorator'
require_relative '../person'

describe 'Unit Test of capitalize_decorator' do
  before(:each) do
    @capitalize_decorator = CapitalizeDecorator.new
  end

  it 'should return NotImplementedError' do
    expect { @capitalize_decorator.correct_name }.to raise_error(NotImplementedError)
  end

  it 'should return the capitalize name' do
    person = Person.new(25, 'John Doe')
    capitalize = CapitalizeDecorator.new(person)
    expect(capitalize.correct_name).to eql('John doe')
  end
end
