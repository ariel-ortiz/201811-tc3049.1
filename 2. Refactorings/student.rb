class Student
  
  GOOD_GRADE = 85
  POVERTY_LEVEL_INCOME = 15_000

  attr_reader :name, :id, :anual_income

  def initialize(name:, id:, anual_income:)
    @name = name
    @id = id
    @anual_income = anual_income
    @grades = []
  end

  def add_grade(grade)
    @grades << grade
    self
  end

  def display_personal_information_and_disclaimer
    display_personal_information
    display_disclaimer
  end

  def scholarship_worthy?
    return raise "No grades!" if @grades.empty?

    has_good_grades = (average >= GOOD_GRADE)
    is_poor = (@anual_income < POVERTY_LEVEL_INCOME)
    has_good_grades and is_poor
  end
  
  private
  
  def average
    @grades.sum / @grades.size.to_f
  end

  def display_personal_information
    puts "Name: #{ @name } ID: #{ @id }"
    puts "Anual income: #{ @anual_income }"
    puts "Grade average: #{ average }"
  end

  def display_disclaimer
    puts 'The contents of this class must not be considered an offer,'
    puts 'proposal, understanding or agreement unless it is confirmed'
    puts 'in a document signed by at least five blood-sucking lawyers.'
  end
  
end