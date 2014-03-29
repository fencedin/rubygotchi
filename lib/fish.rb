class Fish < ActiveRecord::Base
  validates :name, presence: true,
                   presence: {message: "your freind"},
                   length: {maximum: 11,
                            message: "is long"},
                   uniqueness: true,
                   uniqueness: {message: "is taken in past",
                                case_sensitive: false}


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

