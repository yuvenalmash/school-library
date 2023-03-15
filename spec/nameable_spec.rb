require_relative '../nameable'

describe 'Unit Test of nameable' do
  before(:each) do
    @nameable = Nameable.new
  end

  it 'should return NotImplementedError' do
    expect {@nameable.correct_name}.to raise_error(NotImplementedError)
  end
end
