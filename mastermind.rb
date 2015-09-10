class Mastermind

	def initialize
		@possible_colors = ["r", "o", "y", "g", "b", "p"]
		@secret_colors = []
		@game_won = false
		begin_game
	
	end

	def begin_game
		set_up_code
		print_introduction
		play_game
	end

	def set_up_code #computer chooses a secret code
		4.times do
			color = rand(6)
			@secret_colors.push(@possible_colors[color])
		end
	end

	def print_introduction #prints rules
		puts "Welcome to mastermind!"
		puts "I have a code made of four colors"
		puts "You have 12 turns to guess my code"
		puts "r = red, o = orange y = yellow, g = green, b = blue, p = purple"
		#puts "testing"
		#puts @secret_colors
	end

	def get_guess #gets input from player each turn
		puts "please choose four colors"
		guess_input = gets.downcase.chomp.delete(" ")
		guess_array = guess_input.split("")
		return guess_array
	end

	def play_game
		turn = 1
		while @game_won == false && turn < 13
			guess = get_guess
			compare_codes(guess)
			turn += 1
		end
		if @game_won == true
			puts "You win!  My code was #{@secret_colors}"
		else 
			puts "Too many guesses! You lose! My code was #{@secret_colors}"
		end
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

		puts "You have #{perfect_match} perfect matches and #{color_match} color matches."
		perfect_match = 0
		color_match = 0
	end

end

game = Mastermind.new