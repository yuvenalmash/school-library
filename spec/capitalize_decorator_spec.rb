require_relative '../capitalize_decorator'

describe 'Unit Test of capitalize_decorator' do
  before(:each) do
    @capitalize_decorator = CapitalizeDecorator.new
  end

  it 'should return NotImplementedError' do
    expect { @capitalize_decorator.correct_name }.to raise_error(NotImplementedError)
  end
end
