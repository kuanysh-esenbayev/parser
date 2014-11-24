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
		parse_all(html)
		# parse_address(html)

	end
	def parse_all(html)
		super

	end
	# def parse_address(html)
	# 	super
	# end

end