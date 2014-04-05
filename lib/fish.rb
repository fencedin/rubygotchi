class Fish < ActiveRecord::Base
  validates :name, presence: true,
                   presence: {message: "your freind"},
                   length: {maximum: 10,
                            message: "is long"},
                   uniqueness: true,
                   uniqueness: {message: "is taken in past",
                                case_sensitive: false}


#FEED
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
    age_update(fish_id)
    if rand(3) == 0
      fish.unscold(fish.id)
    end
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
        if rand(3) == 0
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
  def try_happy(fish_id)
    fish = Fish.find(id = fish_id)
    age_update(fish_id)
    if rand(3) == 0
      fish.unfeed(fish.id)
    end
    if fish.mood == "☻☻☻☻☻☻☻☻☻☻"
      if rand(3) == 0
        fish.unscold(fish.id)
      end
    else
      if fish.hunger == "◼◼◼◼◼◼◼◼◼◼"
        fish.happy(fish.id)
      elsif fish.hunger.gsub('◻', '').size > 5
        if rand(3) == 0
          fish.happy(fish.id)
        end
      else
        if rand(5) == 0
          fish.happy(fish.id)
        end
      end
    end
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
  def try_scold(fish_id)
    fish = Fish.find(id = fish_id)
    age_update(fish_id)
    if rand(3) == 0
      fish.unhappy(fish.id)
    end
    if fish.discipline == "✦✦✦✦✦✦✦✦✦✦"
      if rand(3) == 0
        fish.unhappy(fish.id)
      end
    else
      if fish.mood == "☻☻☻☻☻☻☻☻☻☻"
        fish.scold(fish.id)
      elsif fish.mood.gsub('☻', '').size > 5
        if rand(2) == 0
          fish.scold(fish.id)
        end
      else
        if rand(4) == 0
          fish.scold(fish.id)
        end
      end
    end
  end

#AGE
  def age_update(fish_id)
    fish = Fish.find(id = fish_id)
    if (fish.hunger.gsub('◼', '').size + fish.mood.gsub('☻', '').size) > 18
      fish.update(age: 95)
    elsif (fish.age % 10 == 0) && (fish.age < 100)
      if rand(3) == 0
        fish.update(age: (fish.age+10))
      else
        fish.update(age: (fish.age+1))
      end
    elsif (fish.age % 2 == 0)
      fish.update(age: (fish.age+3))
    else
      fish.update(age: (fish.age+1))
    end
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

