# Bad Boys of the NFL

Curious which Chicago Bears players have been to jail? What are their crimes? HAVE YOU BEEN A VICTIM OF AN INJUSTICE AT THE HANDS OF AN NFL PLAYER?? This app is for you.

## Getting Started

Follow the following instructions to use our CLI app on your very own computer.

### Download

1. Clone this repository.
2. Change into the newly cloned directory in your terminal.

### Setup and Start
If this is your first time running the program:
1. Run 'bundle install'.
2. Run 'rake db:migrate'
3. Run 'rake db:seed'
4. Run 'ruby bin/run.rb'
If you want to reseed your database:
1. Run 'rake refresh' to reseed and start the program.

## Usage

This app has many useful functions that allow you to manipulate our new database we acquired from the API detailing NFL player arrests. 

### Expectations

You will be greeted, and given two options. 
Press 1 to see a list of players with the ability to enter a player's name that will give you certain abilities regarding this player's arrest data. Use the up and down arrow keys and enter to select the option.
Press 2 to see a list of crimes that players have committed with the ability to enter the name of a crime that will give you certain abilities regarding data for that crime. Use the up and down arrow keys and enter to select the option. 

### Player Abilities
1. Pardon: Delete one of the chosen player's arrests. Use the up and down arrow keys to choose the arrest and it's deleted from the database. If the player has no other arrests, the player is also deleted from the database.
2. Pardon All: Delete ALL of the player's arrests. He is then deleted from the database.
3. Snitch: Create a new arrest connected to the chosen player. You will be asked to input data regarding the specifics of the arrest.
4. New Dad: Update the chosen player's name to add ' Sr' to the end of it.
5. Google It: Use the up and down arrow keys to choose which arrest you would like to see the url for its google search.

### Crime Abilities
1. Who Dun It: See a list of players who have committed this crime.
2. Day Most Likely to Happen: See which day this crime has happened the most on.

### End of the Line
Once you go through one of the player options or crime options, you will be given the option to start the app from the beginning or exit it.


## Built With
TTYToolkit 
ActiveRecord
SQLite3
NFLarrest.com API

## License
This project is licensed under the MIT License - see the LICENSE.md file for details
