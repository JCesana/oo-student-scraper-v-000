require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    puts student_hash["name"]
    @@all << self 
  end

  def self.create_from_collection(students_array)
    
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    @@all 
  end
end

test = Student.new({:name=>"Alex Patriquin", :location=>"New York, NY"})
binding.pry 