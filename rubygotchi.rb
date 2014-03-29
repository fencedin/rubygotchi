require 'bundler/setup'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])


# MAIN MENU =================================================
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
    else
      error
    end
  end
end

# CREATE MENU ===============================================
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
  @current = Fish.create(name: name, gender: gender)
  clear
  puts "New friend \e[1;32m#{name}#{gender}\e[0;0m  has born…"
  game
end

# GAME ======================================================


# OTHER =====================================================


def welcome
  puts "\e[43mThank for Rubygotchi™ you choosing.\e[0m"
	main_menu
end

def prompt
  print "\e[96myou response \e[5;96m➤ \e[0;0m"
end

def error
	clear
	puts "\e[5;31m Σʁʁ☹я \e[0;0m"
end

def clear
	system "clear && printf '\e[3J'"
end

# USE LATER

# ♂ ♀ ☿ ⁂

# START =====================================================
clear
welcome
