class User < ApplicationRecord
  has_many :events, :foreign_key => :creator_id
  has_many :event_attendees,  :foreign_key => :attendee_id
  has_many :attended_events,  :through => :event_attendees
  before_save { self.email = email.downcase }
          validates :name, presence: true, length: { maximum: 50 }
          VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
          validates :email, presence: true, length: { maximum: 255 },
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: false }
          has_secure_password
          validates :password, presence: true, length: { minimum: 6 }

          def User.digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                          BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
          end
          
          
# ------------------- Event and EventAttendee Methods ---------------------

    	def upcoming_events
    		self.attended_events.upcoming
    	end
    
    	def previous_events
    		self.attended_events.past
    	end	
    
    	def attending?(event)
    		event.attendees.include?(self)
    	end
    
    	def attend!(event)
    		self.event_attendees.create!(attended_event_id: event.id)
    	end
    
    	def cancel!(event)
    		self.event_attendees.find_by(attended_event_id: event.id).destroy
    	end

# ------------------- End of Event and EventAttendee Methods --------------
          
end
