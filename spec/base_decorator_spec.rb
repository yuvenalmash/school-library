require_relative '../base_decorator'

describe 'Unit Test of base_decorator' do
  before(:each) do
    @base_decorator = BaseDecorator.new
  end

  it 'should return NotImplementedError' do
    expect{@base_decorator.correct_name}.to raise_error(NotImplementedError)
  end
end
