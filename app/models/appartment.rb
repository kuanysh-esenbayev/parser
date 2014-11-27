class Appartment < Irr
  include Mongoid::Document
  include Mongoid::Timestamps

  field :floor,           type: Integer
  field :totalFloor,      type: Integer
  field :areaTotal,       type: String
  field :seria,           type: String
  field :areaLive,        type: String
  field :areaCanteen,     type: String
  field :decoration,      type: String
  field :wc,              type: String
  field :roof,            type: String
  field :waterSystem,     type: String
  field :heatingSystem,   type: String

  field :lift,            type: Boolean
  field :garbage,         type: Boolean
  field :telephone,       type: Boolean
  field :internet,        type: Boolean
  field :balkon,          type: Boolean

  field :numberOfRooms, type: Integer
  field :yearOfBuild,   type: Integer
  field :secuirity,     type: Boolean


	def parser(html)

      pair = []

      container = html.css('.content_left .form_info')

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
      parse_phone(html)
      # parse_contact(html)
      parse_photo(html)

      parse_text(html)
      parse_all(pair)
      parse_other(pair)
      # raise



	end
  def parse_other(pair)   
      map = {
      :numberOfRooms => "Комнат в квартире:",
      :lift => "Лифты в здании:",
      :garbage => "Мусоропровод:",
      :telephone => "Телефон:",
      :internet => "Интернет:",
      :balkon => "Балкон/Лоджия:",
      :floor => "Этаж:",
      :totalFloor => "Этажей в здании:",
      :areaTotal => "Общая площадь:",
      :seria => "Серия:",
      :areaLive => "Жилая площадь:",
      :areaCanteen => "Площадь кухни:", 
      :decoration => "Отделка:",
      :wc => "Санузел:",
      :roof => "Высота потолков:",
      :waterSystem => "Система водоснабжения:",
      :heatingSystem => "Система отопления:",
      :yearOfBuild => "Год постройки/сдачи:",
      :secuirity => "Охрана здания:",


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
      # raise
  end
	
end