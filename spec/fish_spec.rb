require 'spec_helper'

describe Fish do
  context '.gender_random' do
    it 'should return a random gender' do
      Fish.gender_random.should_not eq ""
    end
  end
end
