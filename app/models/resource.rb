class Resource < ActiveRecord::Base

	scope :a_to_z, lambda {order("resources.name ASC")}

	acts_as_list scope: [:position]

	belongs_to :resource_type

	validates_presence_of :name, :link, :image

	has_attached_file :image, :styles => { 
		:small =>  ['300x300'],
		:medium => ['450x450'],
		:large =>  ['1200x1200>']
	}, 
	:default_url => "image.svg"
	
  	validates_attachment_content_type :image, 
  content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/

  	before_validation :format_url

	private

	def format_url
		if self.link.nil?
			unless self.link[/\Ahttp:\/\//] || self.link[/\Ahttps:\/\//]
	    		self.link = "http://#{self.link}"
	  		end
	  	end
	end

end
