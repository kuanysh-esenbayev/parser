class Irr
  include Mongoid::Document
  include Mongoid::Timestamps

  field :repair,      type: String

  field :price,         type: Integer
  field :text,          type: String
  field :numberOfRooms, type: Integer
  field :yearOfBuild,   type: Integer
  field :secuirity,     type: Boolean
  field :gaz,           type: Boolean
  field :material,      type: String
  field :address,       type: String
  field :contact,       type: String
  field :skype,         type: String
  field :webpage,       type: String
  field :phone,         type: Array, default: []
  field :photo,         type: Array, default: []


def parse_photo(html)
  photo = []
  container = html.css('.slider_wrap .slider .slides .slide')

  (0..container.count-1).each{|p| photo << container[p].css('.nyroModal').attr('href').text}

  self.photo = photo
  # raise
  
end
def parse_text(html)
  text = html.css('.content_left p.text')
  title = html.css('.content_left span.title')
  self.text = text.text
  # raise
end

  def parse_phone(html)
    container = html.css(".content_left .form_info")

    phone = container.css('#allphones').attr('value').text

    contact = container.css('li')
    values = contact.css('p')

    pair2 = []
    (0..values.count-1).step(2).each { |i|
      if (values[i].text == "Телефон:" || values[i].text == "E-mail:")
        next
      elsif values[i].text == "Продавец:"
        self.contact = values[i+1].text.strip
      end
      pair2 << [values[i] && values[i].text,values[i+1] && values[i+1].text] }

    var = Base64.decode64(phone).split

    b = []
    var.each{|s| 
      if s.include?('http')
        b<<s
      end
    }

    self.phone = b

    
  end

  def parse_all(pair)
    map = {
      
      :repair => "Ремонт:",
        
      # :numberOfRooms => "Количество комнат:",
      # :yearOfBuild => "Год постройки/сдачи:",
      # :secuirity => "Охрана:",
      :gaz => "Газ в доме:",
      :material => "Материал стен:",
      :webpage => "Сайт:"
  
    }

    pair.each do |i|
      title = i.first
      value = i.last

      res = map.select do |k, v|
        v == title
      end
    
      self[res.key(title)] = value
    end
  # raise
  end
end