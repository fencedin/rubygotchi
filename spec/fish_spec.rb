require 'spec_helper'

describe Fish do
  it { should validate_presence_of(:name).with_message('your freind')}
  it { should validate_uniqueness_of(:name).with_message('is taken in past')}
  it { should ensure_length_of(:name).is_at_most(10).with_message('is long') }
  it { should validate_uniqueness_of(:name).case_insensitive.with_message('is taken in past') }

  context '.gender_random' do
    it 'should return a random gender' do
      Fish.gender_random.should_not eq ""
    end
  end

  context '#feed' do
    it 'should add 1 to hunger' do
      fish = Fish.create(name: "test", hunger: "◼◻◻◻◻◻◻◻◻◻")
      fish.feed(fish.id)
      fish.reload
      fish.hunger.should eq "◼◼◻◻◻◻◻◻◻◻"
    end
  end
end
