class Player < ActiveRecord::Base
    has_many :arrests
    has_many :crimes, through: :arrests

    # def crimes_and_frequency
    #     # returns a hash of crime keys with value of the frequency of each crime
    # end
    
end