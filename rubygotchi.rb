require 'bundler/setup'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }





# OTHER =====================================================


def welcome
	puts "Welcome"
	gets.chomp
end

def error
	clear
	puts "Error"
end

def clear
	system "clear && printf '\e[3J'"
end

clear
welcome