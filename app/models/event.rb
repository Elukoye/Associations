class Event < ApplicationRecord
  belongs_to :creator, :class_name => "User"
  has_many :attendees, 		:through => :event_attendees
  has_many :event_attendees,  :foreign_key => :attended_event_id
end
