require_relative './teacher'

describe '#teacher' do
  context 'when the teacher is created' do
    it 'should be an instance of Teacher' do
      new_teacher = Teacher.new(30, 'Math', 'Anna', parent_permission: true)
      expect(new_teacher).to be_instance_of Teacher
    end
    it 'Working of can_use_services?' do
      new_teacher = Teacher.new(30, 'Math', 'Anna', parent_permission: true)
      expect(new_teacher.can_use_services?).to be true
    end
  end
end
