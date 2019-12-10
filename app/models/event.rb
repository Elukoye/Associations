class Event < ApplicationRecord
  belongs_to :creator, :class_name => "User"
  has_many :event_attendees, :foreign_key => :attended_event_id
  has_many :attendees, :through => :event_attendees 
 

  scope :upcoming, -> { where("Date >= ?", Date.today).order('Date ASC') } 
  scope :past, -> { where("Date < ?", Date.today).order('Date DESC') }
  
  validates :creator_id, presence: true 
  validates :location, presence: true, length: { maximum: 100 } 
  validates :location, presence: true, length: { maximum: 250 } 
  validates :description, presence: true
  
end
