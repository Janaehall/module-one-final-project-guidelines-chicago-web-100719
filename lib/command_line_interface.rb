
require 'pry'
PROMPT = TTY::Prompt.new
HEADER = (TTY::Box.frame "BAD BOYS OF THE NFL").red
CLEAR = puts "\e[H\e[2J"

def clear #Clears the terminal
    puts "\e[H\e[2J"
    puts HEADER
end

def welcome #Displays Welcome message
    puts "\nWelcome to the Official NFL Player Arrest App!\n\n"
end

def get_input(input) #Run all user input through here
    if input.to_i == 0
        input = input.downcase.titleize
    else input = input.to_i
    end
    clear
    input
end


    def find_player(player)
        Player.find_by(name: player)
    end

    def most_common_crimes #Formats and displays Crime#most_common_crime_by_day
        puts "\nPlease enter a day of the week:\n"
        day = get_input(gets.chomp)
        puts "\nMost common crimes for #{day}:\n"
        puts Crime.most_common_crimes_by_day(day)
    end

    def which_day_of_the_week   #Formats and displays Crime#occurs_most_often_on_day
        puts "\nPlease enter a category of crime: \n"
        crime_type = Crime.find_by(category: get_input(gets.chomp))
        puts "\nMost NFL players seem to commit #{crime_type.category} crimes on #{crime_type.occurs_most_often_on_day}."
    end

def view_player_arrests(player)     #Formats and displays player arrests
    n = 1
    # J'Marcus Webb doesn't work
    player.arrests.each do |arr|
        puts "#{n}.Arrested for #{arr.crime.category} on #{arr.date}\n"
        n += 1
    end
    player.arrests
end

def players_or_crimes   #Initial player/crime menu
    puts table = "----------------------------------------------------"
    puts "|  Enter '1' for Players  |  Enter '2' for Crimes  |"
    puts table
end

def players_option      #Displayed when user selects 'players'
    puts "\nNFL players guilty of committing crimes:\n"
    puts Player.name_table
    puts "\nEnter a player name to view arrests:\n"
end

def menu_for_player_input(user_input, player)
    input = nil
    until input do
        input = ["P", "Pardon", "Pardon All", "A", "S", "N", "G", "Pardon All", "Snitch", "New Dad", "Google it"].include?(user_input)
        unless input
            puts "Your selection was invalid".yellow
            menu_for_player(player)
        end
    end
    user_input

end

def menu_for_player(player)     #Options for each player
    puts "\nPlease select one of the following:\n"
    puts ["(P)ardon", "Pardon (A)ll", "(S)nitch", "(N)ew Dad", "(G)oogle it"]
    select = menu_for_player_input(get_input(gets.chomp), player)
    player_choices(select, player)
end

def googler(player, input)  #Google user arrest by selection menu
    arrest = PROMPT.select("\nPlease select one of #{player.name}'s crimes to Google!\n") do |menu|
        menu.enum '.'
        view_player_arrests(player).each do |arr|
            menu.choice "Arrested for #{arr.crime.category} on #{arr.date}\n", arr
        end

    end
    arrest.google_it
end

def take_player_input
    player = nil
    until player do
        player = find_player(get_input(gets.chomp))
        unless player
            Player.name_table
            puts "\nNot on the list. Try again:\n".yellow
        end
    end
    player
end

def take_crime_input(arg)

    crime = Crime.all.find { |c| c.category.downcase.titleize == get_input(arg) }
    if crime
        return crime
    else 
        clear
        puts Crime.category_table
        puts "Not on the list. Try again:\n".yellow
        take_crime_input(gets.chomp)
    end
end

def sign_off_message        #Displayed when user exits program
    puts "\nThanks for using the NFL Crime App! Goodbye!\n"
end

def snitch_on_player(player)    #Format and display Player#snitch
    puts "Report a crime for #{player.name}!\n\n"
    puts "On which day of the week did this crime occur?\n"
    day_of_week = get_input(gets.chomp)
    puts "What was the date of the crime? (YYYY-MM-DD)\n"
    date = gets.chomp
    clear
    puts "How would you categorize this crime?\n"
    crime = get_input(gets.chomp)
    puts "Provide a brief description of the crime:\n"
    description = gets.chomp
    clear
    player.snitch(day_of_week, date, description, crime)
    puts "Thank you for reporting #{player.name} for #{crime}! We'll add it to our database\n\n"
end

def player_choices(input, player)
    case input
    when "P","Pardon"
        player.pardon
        view_player_arrests(player)
        if player.arrests.count < 1
            puts "\n#{player.name} has been absolved of all his crimes.\n"
        else 
            puts "\n#{player.name} has been pardoned for his most recent crime.\n"
        end

    when "S","Snitch"
        snitch_on_player(player)
    when "N", "New Dad"
        player.new_dad
        puts "\nCongratulations on procreating, #{player.name}!\n\n"
    when "G", "Google"
        googler(player, input)
    when "A", "Pardon All"
        player.pardon_all
        player.delete
        puts "\n#{player.name} has been absolved of all his crimes!\n"
    else
        clear              
        puts "Not an option\nPlease select something from the list:/n".yellow
        player_choices
    end
end

    def crime_choices(crime_instance)
        menu_for_crime
        choice = get_input(gets.chomp)
        case choice
        when 'W'
            clear
            # puts crime_instance.category.downcase.titleize
            puts crime_instance.category
            puts "\nWho Dun It?\n"
            crime_instance.who_dun_it
        when 'D'
            # crime_instance.occurs_most_often_on_day
            clear
            # puts crime_instance.category.downcase.titleize
            puts crime_instance.category
            puts "\nDay Most Likely to Happen...\n"
            arrests2 = crime_instance.arrests.map { |a| a.day_of_week }
            puts "\n"
            puts arrests2.max_by { |a| arrests2.count(a) }
            puts "\n"
        else 
            clear              
            puts "not an option".yellow
            crime_choices(crime_instance)
        end
    end

    def menu_for_crime
        puts "(W)ho dun it?\n"
        puts "(D)ay most likely to happen...\n"
    end
