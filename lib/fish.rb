class Fish < ActiveRecord::Base




private

  def self.gender_random
    r = rand(3)
    if r == 0
      '♂'
    elsif r == 1
      '♀'
    else
      '☿'
    end
  end

end

