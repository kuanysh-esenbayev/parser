class Irr
  include Mongoid::Document
  include Mongoid::Timestamps

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



  def parser(html)
    raise 
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
raise


  end





  def parse_all(pair)
    map = {
      :numberOfRooms => "Количество комнат:",
      :yearOfBuild => "Год постройки/сдачи:",
      :secuirity => "Охрана:",
      :gaz => "Газ в доме:",
      :material => "Материал стен:"
    }

    pair.each do |i|
      title = i.first
      value = i.last

      res = map.select do |k, v|
       v == title
      end
    
      self[res.key(title)] = value
    end
  end
end