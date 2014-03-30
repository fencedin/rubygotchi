require 'bundler/setup'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])


# MAIN MENU ===============================================
def main_menu
  choice = nil
  until choice == 'x'
    puts "==================================="
    puts "Select option below on… "
    puts "   [c]reate"
    puts "   [r]esume"
    puts "  e[x]it"
    puts "==================================="
    prompt
    choice = gets.chomp
    case choice
      when 'c'
        create_menu
      when 'r'
        resume_menu
      when 'x'
        clear
        puts "\e[43mBye Bye for you now… \e[0m\n\n"
        exit
      else
        error
    end
  end
end

# CREATE MENU =============================================
def create_menu
  puts "You are to create new friend"
  puts "name it"
  name = gets.chomp
  puts "Do like [b]lue [g]reen [y]ellow or [r]ed?"
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
  @current = Fish.new(name: name, gender: gender, hunger: "◼◻◻◻◻◻◻◻◻◻", mood: "☻☻☻☻☻☺☺☺☺☺", discipline: "✧✧✧✧✧✧✧✧✧✧")
  if @current.save
    clear
    puts "New friend \e[1;32m#{name}#{gender}\e[0;0m  has born…"
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
  puts "\e[4;39mAll friends list:\e[0;0m"
  Fish.all.each {|f| puts "#" + f.id.to_s + " "*(4-f.id.to_s.length) + " "+ f.name }
  puts "\nEnter number of friend to resume"
  select = gets.chomp
  if Fish.where(id: select).length > 0
    clear
    @current = Fish.find(id = select)
    game
  else
    error
  end
end

# GAME ====================================================
def game
  screen
  game_menu
end

def game_menu
  puts "Select option below on… "
  puts "   [f]eed friend"
  puts "   [g]ive friend attention"
  puts "   [s]cold friend"
  puts "   [b]ack to main menu"
  puts "==================================="
  prompt
  case gets.chomp
    when 'f'
      @current.feed(@current.id)
      @current.reload
      clear
      game
    when 'u'
      @current.unfeed(@current.id)
      @current.reload
      clear
      game
    when 'g'
    when 's'
    when 'b'
      clear
      main_menu
    else
      error
      game
  end
end

# OTHER ===================================================
def welcome
  puts "\e[43mThank for Rubygotchi™ you choosing.\e[0m"
	main_menu
end

def prompt
  print "\e[96myou response \e[5;96m➤ \e[0;0m"
end

def error
	clear
	puts "\e[5;31m⋙ ⋙ ⋙  Σʁʁ☹я ⋘ ⋘ ⋘\e[0;0m"
end

def clear
	system "clear && printf '\e[3J'"
end

def screen
  puts "==================================="
  puts "          Name: [ \e[32m" + @current.name + @current.gender + " "*(9-@current.name.length) + "\e[0m ]"
  puts "        Hunger: [ \e[32m#{@current.hunger}\e[0m ]"
  puts "         Happy: [ \e[32m#{@current.mood}\e[0m ]"
  puts "    Discipline: [ \e[32m#{@current.discipline}\e[0m ]"
  puts "\n"

  print <<FISH
              \e[34mo\e[0m
                \e[34mo\e[0m  \e[33m_\e[0m
               \e[34mo\e[0m \e[33m_//}_
                / o ~~\\\/}
                \\   ))/\\}
                 `---`\e[0m

FISH
  puts "==================================="

end


# USE LATER
  # ⁂ ☠
  # ♥♡ ☻☺ ✦✧ ◼▢▢▢▢◽▢▢▢▢ ▣▢▢▢▢▢▢   ◼◼◼◻◻◻

# ONLOAD ==================================================

clear
welcome
