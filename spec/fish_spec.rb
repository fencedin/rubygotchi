require 'spec_helper'

describe Fish do
  it { should validate_presence_of(:name).with_message('your freind')}
  it { should validate_uniqueness_of(:name).with_message('is taken in past')}
  it { should ensure_length_of(:name).is_at_most(11).with_message('is long') }
  it { should validate_uniqueness_of(:name).case_insensitive.with_message('is taken in past') }

  context '.gender_random' do
    it 'should return a random gender' do
      Fish.gender_random.should_not eq ""
    end
  end

end
