class EventAttendee < ApplicationRecord
  belongs_to :attendee, 		:class_name => "User"
  belongs_to :attended_event, :class_name => "Event"
  has_many :event_attendees, :foreign_key => :attended_event_id


  validates :attended_event_id, 	presence: true
  
end
