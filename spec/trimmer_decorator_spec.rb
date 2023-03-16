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

  it 'should return the trim the name if it is more that 10 ' do
    person = Person.new(25, 'Maximilianus')
    trim = TrimmerDecorator.new(person)
    expect(trim.correct_name).to eql('Maximilian')
  end
end
