require "pry"

class Student
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name,grade)
    @name, @grade = name, grade
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  def self.create_table
    DB[:conn].execute("CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT);")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students;")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?);", self.name, self.grade)
    @id = DB[:conn].execute("SELECT id FROM students").flatten[0]
  end

  def self.create(student_hash)
    student = Student.new(student_hash[:name],student_hash[:grade])
    student.save
    student
  end
end
