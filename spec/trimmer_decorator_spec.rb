require_relative '../trimmer_decorator'

describe 'Unit Test of trimmer_decorator' do
  before(:each) do
    @trimmer_decorator = TrimmerDecorator.new
  end

  it 'should return NotImplementedError' do
    expect { @trimmer_decorator.correct_name }.to raise_error(NotImplementedError)
  end
end
