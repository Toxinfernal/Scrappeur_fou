require 'nokogiri'
require 'pry'
require 'rspec'
require 'rubocop'
require 'open-uri'

def la_page
  page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr&fbclid=IwAR3U3jg26RZnwL6Iu7FEKI3HGimHvosVNjTlNON1y7o1Irx4Xxlue332qZc"))
  return page
end

def name
  page = la_page
  prenom = page.xpath("//*[@class='titre_normal']")
  prenom_array = []
  prenom.each do |index_prenom|
    prenom_array << { "first_name" => index_prenom.text.split(" ")[1], "last_name" => index_prenom.text.split(" ")[2]}
  end
  puts prenom_array
  return prenom_array
end

def email
  page = la_page
  email = page.xpath('//*[contains(text(), "@assemblee-national")]')
  email_array = []
  email.each do |index_email|
    email_array << index_email.text
  end
  puts email_array
  return email_array
end

def name_email
  prenom_array = name
  email_array = email
  name_email_array = []
  prenom_array.each_with_index do |name, email|
    name_email_array << {name => (email_array)[email]}
  end
  puts name_email_array
  return name_email_array
end

name_email
