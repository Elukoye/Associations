require 'rails_helper'
 
RSpec.describe User, :type => :model do
  subject{described_class.new(name:'nil',email:'nil',password:'nil')}
  
  it 'is valid with a name of max 50 characters' do
     subject.name = 'Foo'
  end
  
  it 'is valid with a email of correct format' do
     subject.email= 'foo@example.com'
  end
  
  it 'is valid with a password of min 6 characters' do
     subject.name = 'FooFoo'
  end
  
  it 'is not valid without name' do
     subject.name = 'nil'
  end
  
   it 'is not valid without an email' do
    subject.email = 'foo@bar.com'
  end
  
  it 'is  not valid with email of incorrect format' do
     subject.email = 'foo@bar,com'
  end
  
  it 'is not valid without password' do
   subject.password = 'nil'
  end 
  
  describe 'Associations' do
    it 'has many events' do
     assoc = described_class.reflect_on_association(:events)
      expect(assoc.macro).to eq :has_many
    end
    
    it 'has many events' do
     assoc = described_class.reflect_on_association(:attended_events)
      expect(assoc.macro).to eq :has_many
    end
    
    it 'has many events' do
     assoc = described_class.reflect_on_association(:event_attendees)
      expect(assoc.macro).to eq :has_many
    end
  end
  
end