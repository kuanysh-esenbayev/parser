class Appartment < Irr
  include Mongoid::Document
  include Mongoid::Timestamps

  field :floor, type: Integer
  field :totalFloor, type: Integer
  field :areaTotal, type: String
  field :seria, type: String
  field :areaLive, type: String
  field :areaCanteen, type: String
  field :decoration, type: String
  field :wc, type: String
  field :roof, type: Integer
  field :waterSystem, type: String
  field :heatingSystem, type: String
  field :lift, type: Boolean
  field :garbage, type: Boolean
  field :telephone, type: Boolean
  field :internet, type: Boolean
  field :balkon, type: Boolean

	def parser(html)
		
	end
	
end