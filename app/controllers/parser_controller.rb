class ParserController < ApplicationController

	require 'open-uri'
 	require 'nokogiri'
  
	def irr
  	source = params[:source]
  	source ||= 'http://astana.irr.kz/real-estate/apartments-sale/new/1-komn-kv-Arnasay-2-5-ploschad-obschaya-34-kv-m-advert3678696.html'

  	page = Nokogiri::HTML(open(source.to_s,'cookie'=>'puid=b0210a9e3b2d8e198d8f293817671231; csid=7c497c28adeb8b1893ac4d72460a9b194e8e5704; una=1; adview=a%3A1%3A%7Bi%3A3678696%3Bb%3A1%3B%7D; _zero_cc=752fcabbb79049; _zero_ss=5472cf0a8feab.1416810251.1416810251.1; _ym_visorc_1773845=w; __utma=111262172.1659000241.1416658074.1416671491.1416810215.4; __utmb=111262172.9.9.1416810257005; __utmc=111262172; __utmz=111262172.1416671491.3.3.utmcsr=irr.kz|utmccn=(referral)|utmcmd=referral|utmcct=/real-estate/apartments-sale/search/currency=USD/ '))


  	if source.include?('apartments-sale')
  		app = Appartment.new
  		app.parser(page)
  	elsif source.include?('houses')
  		app = Outoftown.new
  		app.parser(page)
  		
  	end

  	@vision = lt

	end
end
