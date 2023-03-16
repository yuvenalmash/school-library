require_relative '../trimmer_decorator'
require_relative '../person'
require_relative '../capitalize_decorator'

describe 'Unit Test of trimmer_decorator' do
  before(:each) do
    @trimmer_decorator = TrimmerDecorator.new
  end

  it 'should return NotImplementedError' do
    expect { @trimmer_decorator.correct_name }.to raise_error(NotImplementedError)
  end

  it 'should return the trim name' do
    person = Person.new(25, 'John Doe')
    trim = TrimmerDecorator.new(person)
    expect(trim.correct_name).to eql('John Doe')
  end
end
