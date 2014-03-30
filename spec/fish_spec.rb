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

# FEED
  context '#feed' do
    it 'should add 1 to hunger' do
      fish = Fish.create(name: "test", hunger: "◼◻◻◻◻◻◻◻◻◻")
      fish.feed(fish.id)
      fish.reload
      fish.hunger.should eq "◼◼◻◻◻◻◻◻◻◻"
    end
  end
  context '#unfeed' do
    it 'should remove 1 to hunger' do
      fish = Fish.create(name: "test", hunger: "◼◼◻◻◻◻◻◻◻◻")
      fish.unfeed(fish.id)
      fish.reload
      fish.hunger.should eq "◼◻◻◻◻◻◻◻◻◻"
    end
  end
  context '#try_feed' do
    it 'should add 1 to hunger when full discipline' do
      fish = Fish.create(name: "test", hunger: "◼◼◻◻◻◻◻◻◻◻", discipline: "✦✦✦✦✦✦✦✦✦✦")
      fish.try_feed(fish.id)
      fish.reload
      fish.hunger.should eq "◼◼◼◻◻◻◻◻◻◻"
    end
  end


#MOOD
  context '#happy' do
    it 'should add 1 to mood' do
      fish = Fish.create(name: "test", mood: "☻☺☺☺☺☺☺☺☺☺")
      fish.happy(fish.id)
      fish.reload
      fish.mood.should eq "☻☻☺☺☺☺☺☺☺☺"
    end
  end
  context '#unhappy' do
    it 'should remove 1 to mood' do
      fish = Fish.create(name: "test", mood: "☻☻☺☺☺☺☺☺☺☺")
      fish.unhappy(fish.id)
      fish.reload
      fish.mood.should eq "☻☺☺☺☺☺☺☺☺☺"
    end
  end

#DISCIPLINE
  context '#scold' do
    it 'should add 1 to discipline' do
      fish = Fish.create(name: "test", discipline: "✦✧✧✧✧✧✧✧✧✧")
      fish.scold(fish.id)
      fish.reload
      fish.discipline.should eq "✦✦✧✧✧✧✧✧✧✧"
    end
  end
  context '#unscold' do
    it 'should remove 1 to discipline' do
      fish = Fish.create(name: "test", discipline: "✦✦✧✧✧✧✧✧✧✧")
      fish.unscold(fish.id)
      fish.reload
      fish.discipline.should eq "✦✧✧✧✧✧✧✧✧✧"
    end
  end

end
