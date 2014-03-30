class Fish < ActiveRecord::Base
  validates :name, presence: true,
                   presence: {message: "your freind"},
                   length: {maximum: 10,
                            message: "is long"},
                   uniqueness: true,
                   uniqueness: {message: "is taken in past",
                                case_sensitive: false}

  def feed(fish_id)
    fish = Fish.find(id = fish_id)
    h = fish.hunger.sub '◻', "◼"
    fish.update(hunger: h)
  end
  def unfeed(fish_id) #for testing
    fish = Fish.find(id = fish_id)
    h = fish.hunger.gsub '◼', "◻"
    fish.update(hunger: h)
  end

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

