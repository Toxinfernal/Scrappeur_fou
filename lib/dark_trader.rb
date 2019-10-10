require 'nokogiri'
require 'pry'
require 'rspec'
require 'rubocop'
require 'open-uri'

#declaration de la page a scrapper
def la_page
  page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  return page
end

#création array des symbols
def scrappeur_de_symbols
  page = la_page
  symbols = page.xpath ('//*[@class="text-left col-symbol"]')
  symbols_array = []
  symbols.each do |index_symbols|
    symbols_array << index_symbols.text
  end
  puts symbols_array
  return symbols_array
end

#création array de prix
def scrappeur_de_prix
  page = la_page
  price = page.xpath ('//*[@class="price"]')
  price_array = []
  price.each do |index_price|
    price_array << index_price.text[1 ... -1].to_f
  end
  puts price_array
  return price_array
end

def scrappeur_global
  symbols_array = scrappeur_de_symbols
  price_array = scrappeur_de_prix
  general_array = []
  symbols_array.each_with_index do |symb, price|
    general_array << {symb => (price_array)[price]}
  end
  puts general_array
  return general_array
end

scrappeur_global
