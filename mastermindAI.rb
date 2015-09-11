class Mastermind

	def initialize
		@possible_colors = ["r", "o", "y", "g", "b", "p"]
		@secret_colors = []
		@game_won = false
		@how_many_colors_in_code = 4
		#should I make the creator and guesser instance so I can use them in puts?
		begin_game
	
	end

	def begin_game
		who_guesses = designate_guesser
		puts who_guesses
		if who_guesses == "You"
			computer_creates
			print_introduction
		else
			human_creates
		end
		play_game(who_guesses)
	end

	def designate_guesser
		puts "Welcome to Mastermind!"
		puts "Would you like to create the code or guess the code?"
		puts "c = create, g = guess"
		who_creates = gets.chomp
		(who_creates == "c") ? "I" : "You"

	end

	def computer_creates
		@how_many_colors_in_code.times do
			color = rand(6)
			@secret_colors.push(@possible_colors[color])
		end
	end

	def human_creates #maybe change later to accept other types of input like with spaces or one at a time
		puts "Please enter your code like this: royg"
		puts "r = red, o = orange y = yellow, g = green, b = blue, p = purple"
		@secret_colors = gets.chomp.split("")
	end

	def print_introduction #prints rules
		puts "I have a code made of four colors"
		puts "You have 12 turns to guess my code"
		puts "r = red, o = orange y = yellow, g = green, b = blue, p = purple"
		#puts "testing"
		#puts @secret_colors
	end

	def human_guess #gets input from player each turn
		puts "please choose four colors"
		guess_input = gets.downcase.chomp.delete(" ")
		guess_array = guess_input.split("")
		return guess_array
	end

	#accounts for both situations I think

	def play_game(guesser)
		turn = 1
		while @game_won == false && turn < 13
			if guesser == "I"
				guess = computer_guess
			else
				guess = human_guess
			end
			puts guess
			compare_codes(guess)
			turn += 1
		end
		if @game_won == true
			puts "#{guesser} win!  The code was #{@secret_colors}"
		else 
			puts "Too many guesses! #{guesser} lose! The code was #{@secret_colors}"
		end
	end

	def computer_guess
		guess = []
			@how_many_colors_in_code.times do
				color = rand(6)
				guess.push(@possible_colors[color])
			end
			return guess
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

		puts "There are #{perfect_match} perfect matches and #{color_match} color matches."
		perfect_match = 0
		color_match = 0
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