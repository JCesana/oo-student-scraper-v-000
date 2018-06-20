require 'nokogiri'
require 'open-uri'
require 'pry'

# DATA:

# List: doc.css("div.roster-cards-container")
# Name: doc.css("div.roster-cards-container div.student-card").first.css("h4").text 
# Location: doc.css("div.roster-cards-container div.student-card").first.css("p").text
# Profile URL: doc.css("div.roster-cards-container div.student-card").first.css("a").attribute("href").value

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_data_list = doc.css("div.roster-cards-container div.student-card")
    
    students = [] 
    
    student_data_list.each do |student|
      students << {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end 
    
    students 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    twitter = nil 
    linkedin = nil 
    github = nil 
    blog = nil 
    profile_quote = nil 
    bio = nil 
    
    student_data = doc.css("div.social-icon-container")
    student_quote = doc.css("div.profile-quote")
    student_bio_data = doc.css("div.details-container div.description-holder p")
    
    student_data.css("a").each do |student|

      if student.attribute("href").value.include?("twitter")
        twitter = student.attribute("href").value 
      elsif student.attribute("href").value.include?("linkedin")
        linkedin = student.attribute("href").value
      elsif student.attribute("href").value.include?("github")
        github = student.attribute("href").value 
      else
        blog = student.attribute("href").value 
      end 

    end 
    
    profile_quote = student_quote.text if student_quote.text
    bio = student_bio_data.text if student_bio_data.text
    
    
    
    student[:twitter] = twitter if twitter
    student[:linkedin] = linkedin if linkedin 
    student[:github] = github if github 
    student[:blog] = blog if blog 
    student[:profile_quote] = profile_quote if profile_quote 
    student[:bio] = bio if bio 
    
    student 
  end

end

# Scraper.scrape_profile_page("./fixtures/student-site/students/david-kim.html")
