class ParserController < ApplicationController

	require 'open-uri'
 	require 'nokogiri'
  
	def irr
  	# source = params[:source]
    
    parse_with_thread() 

    raise







    # pages(source)

	end

  def handler(source)
    # source ||= 'http://irr.kz/real-estate/apartments-sale/search/currency=USD/'
    # source ||= 'http://almaty.irr.kz/real-estate/out-of-town/houses/Dom-284-kv-m-kv-m-Almaty-ploschad-uchastka-8-sotok-advert3917331.html'


    page = Nokogiri::HTML(open(source.to_s,'cookie'=>'puid=45b3136c9bedc0c98db3abe22a976497; csid=c4379aaf7f1060d37b15e3a3b36d2989b34f814b; una=1; adview=a%3A1%3A%7Bi%3A3946783%3Bb%3A1%3B%7D; __utma=111262172.1659000241.1416658074.1416841622.1416983644.10; __utmb=111262172.4.10.1416983644; __utmc=111262172; __utmz=111262172.1416671491.3.3.utmcsr=irr.kz|utmccn=(referral)|utmcmd=referral|utmcct=/real-estate/apartments-sale/search/currency=USD/; _zero_cc=752fcabbb79049; _zero_ss=5475746fb131b.1416983663.1416983663.1; _ym_visorc_1773845=b'))

    container = page.css('.adds_list .add_type4')



    (0..container.count-1).each{|i|  pages(container[i].css('.add_info .add_title').attr('href').text)}
   
  end
  def pages(source)
    page = Nokogiri::HTML(open(source.to_s,'cookie'=>'puid=45b3136c9bedc0c98db3abe22a976497; csid=c4379aaf7f1060d37b15e3a3b36d2989b34f814b; una=1; adview=a%3A1%3A%7Bi%3A3946783%3Bb%3A1%3B%7D; __utma=111262172.1659000241.1416658074.1416841622.1416983644.10; __utmb=111262172.4.10.1416983644; __utmc=111262172; __utmz=111262172.1416671491.3.3.utmcsr=irr.kz|utmccn=(referral)|utmcmd=referral|utmcct=/real-estate/apartments-sale/search/currency=USD/; _zero_cc=752fcabbb79049; _zero_ss=5475746fb131b.1416983663.1416983663.1; _ym_visorc_1773845=b'))


    if source.include?('apartments-sale')
      app = Appartment.new
      app.parser(page)
    elsif source.include?('houses')
      app = Outoftown.new
      app.parser(page)
    end

    # @vision = app
    
  end


  def parse_with_thread
    source = "http://irr.kz/real-estate/apartments-sale/search/currency=USD/list=list/"
    page = Nokogiri::HTML(open(source.to_s,'cookie'=>'puid=45b3136c9bedc0c98db3abe22a976497; csid=c4379aaf7f1060d37b15e3a3b36d2989b34f814b; una=1; adview=a%3A1%3A%7Bi%3A3946783%3Bb%3A1%3B%7D; __utma=111262172.1659000241.1416658074.1416841622.1416983644.10; __utmb=111262172.4.10.1416983644; __utmc=111262172; __utmz=111262172.1416671491.3.3.utmcsr=irr.kz|utmccn=(referral)|utmcmd=referral|utmcct=/real-estate/apartments-sale/search/currency=USD/; _zero_cc=752fcabbb79049; _zero_ss=5475746fb131b.1416983663.1416983663.1; _ym_visorc_1773845=b'))
    
    a = page.css('.adds_list .adds_paging.left ul.same_adds_paging li')


    # raise    


    sources = []
    statuses = []
    (1..a.last.text.to_i).each do |i| 
      sources << "http://irr.kz/real-estate/apartments-sale/search/currency=USD/list=list/page#{i}"
      statuses << false
    end

    sources.each_with_index do |link, index|
      Thread.new(link, index, statuses) do |link, index, statuses|
        a = rand(5)
        handler(link)
        sleep(a)
        statuses[index] = true

      end
    end

    while !statuses.all?
      puts "........"
      sleep(1)
    end

    puts 'ended'
  end

end