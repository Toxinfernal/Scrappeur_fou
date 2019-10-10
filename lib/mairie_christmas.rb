require 'nokogiri'
require 'pry'
require 'rspec'
require 'rubocop'
require 'open-uri'

def la_page
  page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/var.html'))
end
  #methode pour obtenir un email de une mairie du var car c'est mieux
def get_townhall_email
  oui = Nokogiri::HTML(open("http://annuaire-des-mairies.com/83/toulon.html"))
  email = oui.xpath ('//*[contains(text(), "@")]')
  email_array = []
  email.each do |index_email|
    email_array << index_email.text
  end
  puts email_array
end

 #methode pour obetenir les emails de toutes les mairies du var car c'est mieux
def get_townhall_urls
	page = la_page
	urls = page.xpath('//*[@class="lientxt"]/@href') #/ toutes les URLs appartiennent à la classe lientxt
	url_array = []
	urls.each do |url| #/ pour chaque URLs récupérées, il faut leur indiquer l'url parent "http://annuaire-des-mairies.com"
		url = "http://annuaire-des-mairies.com" + url.text[1..-1] #/ A l'url parent, on ajoute les urls récupérées du deuxième caractère au dernier caractère, car on veut se débarasser du point devant.
		url_array << url
	end
  puts url_array

	return url_array
end

get_townhall_urls
