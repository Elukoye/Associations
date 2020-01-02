require 'rails_helper'

RSpec.describe Event, :type => :model do
  subject{described_class.new(location:'nil',description:'nil',date:'nil')}
  
   it 'is invalid without a location' do
      subject.location = 'nil'      
  end
  
   it 'is invalid without a description' do
      subject.description = 'nil'      
  end
  
  it 'is inalid without a date' do
    subject.date = 'nil'
  end 
  
  it 'is valid with a location' do
    subject.location = 'Anything'
  end
  
  it 'is valid with a description' do
    subject.description = 'Anything'
  end 
  
  it 'is valid with a date' do
    subject.date = '12/12/2019'
  end
  
  
  describe "Associations" do
    it 'has one event creator ' do
      assoc= described_class.reflect_on_association(:creator)
      expect(assoc.macro).to eq :belongs_to
    end
    
    it 'has many event attendees' do
      assoc = described_class.reflect_on_association(:event_attendees)
      expect(assoc.macro).to eq :has_many
    end
    
    it 'has many attendees' do
      assoc = described_class.reflect_on_association(:attendees)
      expect(assoc.macro).to eq :has_many
    end
   end
end


