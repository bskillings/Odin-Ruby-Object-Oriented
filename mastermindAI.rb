class Mastermind

	def initialize
		@secret_colors = []
		@game_won = false
		begin_game
	
	end

	def begin_game
		who_guesses = designate_guesser
		if who_guesses == "g"
			@player = Human.new
			@creator = Computer.new
		else
			@player = Computer.new
			@creator = Human.new
		end
		@secret_colors = @creator.create_code
		play_game
	end

	def designate_guesser
		puts "Welcome to Mastermind!"
		puts "Would you like to create the code or guess the code?"
		puts "c = create, g = guess"
		who_creates = gets.chomp
	end

	def play_game#change to if player.name
		turn = 1
		while @game_won == false && turn < 13
			guess = @player.guess_code
			compare_codes(guess)
			turn += 1
		end
		if @game_won == true
			puts "#{@player.name} win!  The code was #{@secret_colors.join}"
		else 
			puts "Too many guesses! #{@player.name} lose! The code was #{@secret_colors.join}"
		end
	end

	def human_guess #gets input from player each turn
		puts "please choose four colors"
		guess_input = gets.downcase.chomp.delete(" ")
		guess_array = guess_input.split("")
		return guess_array
	end

	def compare_codes(guess) #this is long but I use the results from perfect to do color to prevent duplicates
		i = 0
		perfect_match = 0
		color_match = 0
		guess_duplicate = guess.dup
		code_duplicate = @secret_colors.dup
		
		#comparing perfect matches
		while i < guess.length
			if guess[i] == @secret_colors[i]
				perfect_match += 1
				guess_duplicate[i] = "x" #this is so these colors don't show up when I compare colors later
				code_duplicate[i] = "X"
			end
			i += 1
		end
		if perfect_match == guess.length
			@game_won = true
		end
		
		#figuring color matches from what's left
		guess_duplicate.each do |guess_color|
			if code_duplicate.include?(guess_color)
				color_match += 1
				code_duplicate[code_duplicate.find_index(guess_color)] = "Z"
				guess_color = "z"
			end
		end
		if @player.is_a? Computer
			@player.color_matches_from_previous_turn = perfect_match + color_match
		end
		puts "There are #{perfect_match} perfect matches and #{color_match} color matches. \n\n"
		perfect_match = 0
		color_match = 0
	end

end


class Human

	def initialize
		@name = "You"
	end

	def create_code #maybe change later to accept other types of input like with spaces or one at a time
		puts "Please enter your code like this: royg"
		puts "r = red, o = orange y = yellow, g = green, b = blue, p = purple"
		code = gets.chomp.split("")
		puts code
		return code
	end

	def guess_code #gets input from player each turn
		puts "please choose four colors"
		guess_input = gets.downcase.chomp.delete(" ")
		guess_array = guess_input.split("")
		return guess_array
	end

end

class Computer

	attr_accessor :color_matches_from_previous_turn
	attr_accessor :name

	def initialize
		@name = "I"
		@color_matches_from_previous_turn = 0
		@color_index = 0
		@possible_colors = ["r", "o", "y", "g", "b", "p"]
		@last_guess = []
		
	end

	def create_code
		code = []
		4.times do
			color = rand(6)
			code.push(@possible_colors[color])
		end
		puts "I have a code made of four colors"
		puts "You have 12 turns to guess my code"
		puts "r = red, o = orange y = yellow, g = green, b = blue, p = purple"
		return code
		
	end

	def guess_code #not working--gathering colors works but the shuffling part screwed it allup
		
		if @color_matches_from_previous_turn < 4 #make sure to get this
			guess = @last_guess.dup
			guess_index = @color_matches_from_previous_turn
				
			while @color_index < 6 && guess_index < 4#4 should be how many colors in code but I'll have to pass that in
				guess[guess_index] = @possible_colors[@color_index]
				guess_index += 1
			end
		else
			interim_guess = @last_guess.dup
			guess = interim_guess.shuffle
		end

		@last_guess = guess
		@color_index += 1
		puts "I guess #{guess.join}"
		return guess
	end

end



=begin
	
	so what are some of the things I need to account for in making the AI

	making a random guess is easy enough

	perfect matches but don't know which one

	color matches but switch location

	I don't even know the rules to follow to decide what to do 

	http://puzzling.stackexchange.com/questions/546/clever-ways-to-solve-mastermind

	I'm more inclined to do this than the one where you have to make the whole set
	although I might try that one later

	how am I going to split the classes or whatever according to which player is human


=end


game = Mastermind.new