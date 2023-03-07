require_relative 'student'
require_relative 'teacher'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'

student1 = Student.new(13, 'Maths', 'anna', parent_permission: false)
student2 = Student.new(20, 'Maths', 'Maximilianus')
teacher1 = Teacher.new(40, 'Maths', 'julie')
teacher2 = Teacher.new(17, 'Maths', 'Peter', parent_permission: false)

p student1.name
p student2.age
p teacher1.id
p teacher2

p student1.can_use_services?
p student2.can_use_services?
p teacher1.can_use_services?
p teacher2.can_use_services?

p student1.play_hooky

capitalize_student = CapitalizeDecorator.new(student1)
p capitalize_student.correct_name

capitalize_teacher = CapitalizeDecorator.new(teacher1)
p capitalize_teacher.correct_name

trimmer_student = TrimmerDecorator.new(student2)
p trimmer_student.correct_name

trimmer_teacher = TrimmerDecorator.new(teacher2)
p trimmer_teacher.correct_name
