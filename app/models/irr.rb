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
    contact = container.css('#allphones').attr('value').text

    var = Base64.decode64(contact).split

    b = []
    var.each{|s| 
      if s.include?('http')
        b<<s
      end
    }

    self.phone = b
    self.save!
  end
  def parse_address(html)
    
  end
  def parse_all(html)
    pair = []

    container = html.css('div.clear div.additional-features ul.form_info_short')

    titles = container.css("li")
    values = titles.css("p")
    
    (0..values.count-1).step(2).each { |i| pair << [values[i] && values[i].text, 

      if values[i+1].text == ""
        input = values[i+1].css('input[type="checkbox"]').attr('checked').text
        if input == "checked"
          true
        end

      else
       values[i+1] && values[i+1].text 
      end
      ]
    }

    raise
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

    self.save!
    raise    
  end
end