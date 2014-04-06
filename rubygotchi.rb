require 'bundler/setup'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])


# MAIN MENU ===============================================
def main_menu
  choice = nil
  until choice == 'x'
    puts "======================================="
    puts "Select option below on… "
    puts "   [c]reate"
    puts "   [r]esume"
    puts "  e[x]it"
    prompt
    choice = gets.chomp
    case choice
      when 'c'
        clear
        create_menu
      when 'r'
        resume_menu
      when 'x'
        clear
        puts "\a\e[43mBye Bye for you now… \e[0m\n\n"
        exit
      else
        clear
        main_menu
    end
  end
end

# CREATE MENU =============================================
def create_menu
  puts "You are to create new friend"
  puts "   \e[1;39mName\e[0;0m"
  prompt
  name = gets.chomp
  puts "   \e[1;39mDo like \e[34m[b]lue \e[92m[g]reen\e[1;39m or \e[93m[y]ellow\e[1;39m ?\e[0;0m"
  prompt
  gender = gets.chomp
  case gender
    when 'b'
      gender = '♂'
    when 'g'
      gender = '♀'
    when 'y'
      gender = '☿'
    else
      gender = Fish.gender_random
  end
  @current = Fish.new(name: name, gender: gender, hunger: "◼◻◻◻◻◻◻◻◻◻", mood: "☻☻☻☻☻☺☺☺☺☺", discipline: "✧✧✧✧✧✧✧✧✧✧", age: 0)
  if @current.save
    clear
    puts "New friend \e[1;32m#{name}#{gender}\e[0;0m  has born ♡ …"
    game
  else
    clear
    error
    @current.errors.full_messages.each { |message| puts "\e[31m"+message+"\e[0m" }
  end
end

# RESUME MENU =============================================
def resume_menu
  clear
  puts "All friends list:"
  puts "======================================="
  puts "    \e[4;39mID\e[0;0m   \e[4;39mName\e[0;0m"
  Fish.all.sort_by{|f| f.name}.each do |f|
    if f.age > 99
      puts "   \e[31mdead  " + f.name + f.gender + "\e[0;0m"
    else
      puts "   #\e[1;39m" + f.id.to_s + " "*(4-f.id.to_s.length) + " "+ f.name + f.gender + "\e[0;0m"
    end
  end
  puts "======================================="
  puts "Enter number of friend to resume"
  prompt
  select = gets.chomp
  if Fish.where(id: select).length > 0
    clear
    @current = Fish.find(id = select)
    game
  else
    clear
    main_menu
  end
end

# GAME ====================================================
def game
  if @current.age > 99
    puts "\e[1;31m#{@current.name}#{@current.gender}\e[0;0m  has dead ☠ …"
    dead_screen
  else
    if @current.gender == '♂'
      @color = "\e[34m"
    elsif @current.gender == '♀'
      @color = "\e[32m"
    else @current.gender == '☿'
      @color = "\e[33m"
    end
    screen
  end
  game_menu
end

def game_menu
  choice = nil
  until choice == 'b'
    puts "Select option below on… "
    puts "   [f]eed friend"
    puts "   [g]ive friend attention"
    puts "   [s]cold friend"
    puts "   [b]ack to main menu"
    prompt
    choice = gets.chomp
    case choice
      when 'f'
        add_hunger
      when 'g'
        add_mood
      when 's'
        add_discipline
      when 'b'
        clear
        main_menu
      else
        clear
        game
    end
  end
end

# FEED ====================================================
def add_hunger
  if @current.age > 99
    clear
    puts "\e[1;31m#{@current.name}#{@current.gender}\e[0;0m  has dead ☠ …"
    dead_screen
  else
    @current.try_feed(@current.id)
    @current.reload
    clear
    game
  end
end

# HAPPY ===================================================
def add_mood
  if @current.age > 99
    clear
    puts "\e[1;31m#{@current.name}#{@current.gender}\e[0;0m  has dead ☠ …"
    dead_screen
  else
    @current.try_happy(@current.id)
    @current.reload
    clear
    game
  end
end

# SCOLD ===================================================
def add_discipline
  if @current.age > 99
    clear
    puts "\e[1;31m#{@current.name}#{@current.gender}\e[0;0m  has dead ☠ …"
    dead_screen
  else
    @current.try_scold(@current.id)
    @current.reload
    clear
    game
  end
end

# OTHER ===================================================
def welcome
  puts "\a\a\e[43m⁂ Thank for Rubygotchi™ you choosing ⁂\e[0m"
	main_menu
end

def prompt
  puts "======================================="
  print "\e[96mresponse \e[5;96m➤ \e[0;0m"
end

def error
	clear
	puts "\e[5;31m⋙ ⋙ ⋙  Σʁʁ☹я ⋘ ⋘ ⋘\e[0;0m"
end

def clear
	system "clear && printf '\e[3J'"
end

def screen
  puts "======================================="
  puts "|          Name: [ \e[32m" + @current.name + @current.gender + " "*(9-@current.name.length) + "\e[0m ]       |"
  puts "|        Hunger: [ \e[32m#{@current.hunger}\e[0m ]       |"
  puts "|         Happy: [ \e[32m#{@current.mood}\e[0m ]       |"
  puts "|    Discipline: [ \e[32m#{@current.discipline}\e[0m ]       |"
  print <<FISH
|             \e[36mo\e[0m                       |
|               \e[36mo\e[0m  #{@color}_\e[0m                  |
|              \e[36mo\e[0m #{@color}_//}_\e[0m                |
|               #{@color}/ o ~~\\\/}\e[0m             |
|               #{@color}\\   ))/\\}\e[0m             |
|                #{@color}`---`\e[0m                |
FISH
  puts "======================================="
end

def dead_screen
  puts "======================================="
  puts "|          Name: [ \e[32m" + @current.name + @current.gender + " "*(9-@current.name.length) + "\e[0m ]       |"
  puts "|        Hunger: [ \e[32m#{@current.hunger}\e[0m ]       |"
  puts "|         Happy: [ \e[32m#{@current.mood}\e[0m ]       |"
  puts "|    Discipline: [ \e[32m#{@current.discipline}\e[0m ]       |"
  print <<FISH
|                                     |
|                  \e[90m_\e[0m                  |
|                \e[90m_//}_\e[0m                |
|               \e[90m/ X ~~\\\/}\e[0m             |
|               \e[90m\\   ))/\\}\e[0m             |
|                \e[90m`---`\e[0m                |
FISH
  puts "======================================="
end

# ONLOAD ==================================================
clear
welcome
