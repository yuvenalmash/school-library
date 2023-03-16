require_relative '../student'
require_relative '../classroom'

describe 'Unit Test of student' do
  before(:each) do
    @student = Student.new(25, 'Class A', 'John Doe')
  end

  it 'should return the name of the student' do
    expect(@student.name).to eql('John Doe')
  end

  it 'should return the age of the student' do
    expect(@student.age).to eql(25)
  end

  it 'should return the classroom of the student' do
    expect(@student.classroom).to eql('Class A')
  end

  it 'should return the parent_permission of the student' do
    expect(@student.parent_permission).to eql(true)
  end

  it 'should return true if of_age and parent_permission' do
    expect(@student.can_use_services?).to eql(true)
  end

  it 'should return false if not of_age and parent_permission' do
    @student = Student.new(15, 'John Doe', parent_permission: false)
    expect(@student.can_use_services?).to eql(false)
  end

  it 'should return the play_hooky of the student' do
    expect(@student.play_hooky).to eql('¯\(ツ)/¯')
  end

  it 'check the be_instance_of student' do
    expect(@student).to be_instance_of(Student)
  end
end
