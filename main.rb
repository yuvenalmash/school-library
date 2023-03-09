require_relative 'student'
require_relative 'teacher'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require_relative 'rental'
require_relative 'book'
require_relative 'classroom'

classroom1 = Classroom.new('Class A')
classroom2 = Classroom.new('Class B')

student1 = Student.new(13, classroom1, 'anna', parent_permission: false)
student2 = Student.new(20, classroom1, 'Maximilianus')
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

classroom1.add_student(student1)
classroom1.add_student(student2)

book_1 = Book.new('Book 1', 'Author 1')
book_2 = Book.new('Book 2', 'Author 2')
book_3 = Book.new('Book 3', 'Author 3')
book_4 = Book.new('Book 4', 'Author 4')
rental_1 = Rental.new('2021-01-01', book_1, student1)
rental_3 = Rental.new('2021-01-03', book_3, student1)
puts student1.rentals.count
puts student1.rentals.map { |rental| rental.book.title }
puts book_1.rentals.length
book_1.add_rental(student2, '2021-01-04')
rental_3 = Rental.new('2021-01-05', book_3, student2)
student2.add_rental(book_4, '2021-01-05')
book_2.add_rental(student2, '2021-01-05')
puts "book_2 rented #{book_2.rentals.length} times"
puts student2.rentals.length
puts student2.rentals.map { |rental| rental.book.title }
student1.add_to_classroom(classroom1)
puts "#{classroom1.label} has #{classroom1.students.count} students"
puts "#{classroom2.label} has #{classroom2.students.count} students"
puts student1.classroom.label
