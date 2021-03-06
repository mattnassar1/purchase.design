class Admin < ActiveRecord::Base

	scope :a_to_z, lambda {order("admins.last_name ASC")}

	has_and_belongs_to_many :groups
	has_many :person_edits
	has_many :people, :through => :person_edits

	has_secure_password
	validates :password, :presence =>true, :confirmation =>true
  	validates_confirmation_of :password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	FORBIDDEN_EMAIL = ['admin','root']

	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_format_of :email, :with => VALID_EMAIL_REGEX
	
end