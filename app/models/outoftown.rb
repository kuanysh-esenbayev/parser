class Outoftown < Irr
  include Mongoid::Document
  include Mongoid::Timestamps

  field :repair,			type: String
  field :heating,			type: Boolean
  field :water, 			type: Boolean
  field :electricity, 		type: Boolean
  field :canalization, 		type: Boolean
  field :garazh, 			type: Boolean
  field :areaLand, 			type: String
  field :areaBuilding, 		type: String
  field :category, 			type: String
  field :typeOfBuilding,	type: String
  field :typeOfLicence, 	type: String

	def parser(html)
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
	    parse_phone(html)
	    parse_all(pair)
	    parse_other(pair)
	end
	def parse_other(pair)		
	    map = {
	      :repair => "Ремонт:",
		  :heating => "Отапливаемый:",			
		  :water => "Водопровод:", 			
		  :electricity => "Электричество (подведено):", 		
		  :canalization => "Канализация:",	
		  :garazh => "Гараж:", 			
		  :areaLand => "Площадь участка:", 			
		  :areaBuilding => "Площадь строения:", 		
		  :category => "Категория земли:", 			
		  :typeOfBuilding => "Строение:",	
		  :typeOfLicence => "Вид разрешенного использования:"
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