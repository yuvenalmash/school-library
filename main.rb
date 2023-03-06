require_relative 'student'
require_relative 'teacher'

person1 = Student.new(12, 'grade 6', 'Peter', false)
person2 = Student.new(18, 'grade 6', 'George')
person3 = Student.new(32, 'grade 6', 'Andrea', false)
person4 = Teacher.new(40, 'Math', 'Robert')
person5 = Teacher.new(35, 'Math', 'Maria')

p person1.name
p person2.age
p person3.id
p person4
p person5

# person1.speak
# person2.speak
# person3.speak
# person4.speak
# person5.speak

# person1.play_hooky
# person2.play_hooky
# person3.play_hooky
# person4.play_hooky
# person5.play_hooky

p person1.can_use_services?
p person2.can_use_services?
p person3.can_use_services?
p person4.can_use_services?
