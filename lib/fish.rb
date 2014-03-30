class Fish < ActiveRecord::Base
  validates :name, presence: true,
                   presence: {message: "your freind"},
                   length: {maximum: 10,
                            message: "is long"},
                   uniqueness: true,
                   uniqueness: {message: "is taken in past",
                                case_sensitive: false}


#FEED_UI
  def feed(fish_id)
    fish = Fish.find(id = fish_id)
    h = fish.hunger.sub '◻', '◼'
    fish.update(hunger: h)
  end
  def unfeed(fish_id)
    fish = Fish.find(id = fish_id)
    h = fish.hunger.reverse.sub('◼', '◻').reverse
    fish.update(hunger: h)
  end
  def try_feed(fish_id)
    fish = Fish.find(id = fish_id)
    fish.update(age: +1)
    if fish.hunger == "◼◼◼◼◼◼◼◼◼◼"
      if rand(4) == 0
        fish.unhappy(fish.id)
      end
    else
      if fish.discipline == "✦✦✦✦✦✦✦✦✦✦"
        fish.feed(fish.id)
      elsif fish.discipline.gsub('✧', '').size > 5
        if rand(2) == 0
          fish.feed(fish.id)
        end
      else
        if rand(4) == 0
          fish.feed(fish.id)
        end
      end
    end
  end

#MOOD
  def happy(fish_id)
    fish = Fish.find(id = fish_id)
    m = fish.mood.sub '☺', '☻'
    fish.update(mood: m)
  end
  def unhappy(fish_id)
    fish = Fish.find(id = fish_id)
    m = fish.mood.reverse.sub('☻', '☺').reverse
    fish.update(mood: m)
  end

#DISCIPLINE
  def scold(fish_id)
    fish = Fish.find(id = fish_id)
    d = fish.discipline.sub '✧', '✦'
    fish.update(discipline: d)
  end
  def unscold(fish_id)
    fish = Fish.find(id = fish_id)
    d = fish.discipline.reverse.sub('✦', '✧').reverse
    fish.update(discipline: d)
  end

private

#GENDER
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

