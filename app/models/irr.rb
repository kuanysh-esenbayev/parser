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
    raise
    
    (0..titles.count).each { |i| pair << [values] }

    # map = {
    #   :price => ""
    #   :text => ""
    #   :numberOfRooms => ""
    #   :yearOfBuild => ""
    #   :secuirity => ""
    #   :gaz => ""
    #   :material => ""
    #   :address => ""
    #   :contact => ""
    #   :skype => ""
    #   :webpage => ""
    #   :phone => ""
    #   :photo => ""

    # }

    pair.each do |i|
      title = i.first
      value = i.last

      res = map.select do |k, v|
       v == title
      end
    
      self[res.key(title)] = value
    end

    self.save!
    
  end
end