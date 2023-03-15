require_relative '../classroom'

describe 'Unit Test of classroom' do
  it 'should return the label of the classroom' do
    classroom1 = Classroom.new('Class A')
    expect(classroom1.label).to eql('Class A')
  end

  it 'should add a student to the classroom' do
    classroom1 = Classroom.new('Class A')
    expect(classroom1.add_student('student1')).to eql(['student1'])
  end
end
