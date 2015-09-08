class Game

	#Setting up a new game
	def initialize
		@board_status = new_board()
		@player_x = Player.new("X")
		@player_o = Player.new("O")
		@current_player = @player_x
		@swap_player = false
		@win_conditions = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
		@player_won = false
		show_board()
		game()
	end

	def game
		@turns_taken = 0
		while @turns_taken < 10
				turn()
				@turns_taken += 1
		end
		return
	end

	#Creating a blank board
	def new_board()
		@default_box = " - "
		blank_board = Hash.new
		i = 1
		while i < 10
			blank_board[i] = @default_box
			i += 1
		end
		return blank_board
	end

	#Showing the board on the command line
	def show_board
		i = 1
		while i < 10
			print @board_status[i]
			if i % 3 == 0
				puts ""
			end
			i += 1
		end
	end

		#could break this into gets_box, fill_if_possible, and prepare_for_next_turn or something
	def turn() 
		while @player_won == false
			while @swap_player == false 
				puts "#{@current_player.marker}, please choose a square (1-9)"
				chosen_box = gets.chomp.to_i
				@swap_player = check_box?(chosen_box)
			end
			fill_box(chosen_box)
			puts "You chose #{chosen_box.to_s}"
				if check_if_won(@current_player.boxes_filled) == true
				@player_won = true
				turns_taken = 100
				puts "#{@current_player.marker} won!"
			end
			@current_player = (@current_player.marker == @player_x.marker ? @player_o : @player_x)
			@swap_player = false
			show_board
		end
	end
	
	def check_if_won(player_boxes)
		@win_conditions.each do |row|
			test_row = row.dup
			player_boxes.each do |element| 
				if test_row.include?(element) 
					test_row.delete(element)
				end
			end
			if test_row.empty?
				return true
			end
		end
		return false
	end

	def check_box?(box)
		unless @board_status.keys.include?(box)
			puts "please choose a square like this"
			puts "1 2 3" 
			puts "4 5 6"
			puts "7 8 9"
			return false
		end
		unless @board_status[box] == @default_box
			puts "Something is already there"
			return false
		end
		return true
	end

	def fill_box(box)
		@current_player.boxes_filled.push(box)
		@board_status[box] = " #{@current_player.marker} "
	end

end

class Player

	attr_accessor :marker 
	attr_accessor :boxes_filled

	def initialize(marker)
		@marker = marker
		@boxes_filled = []
	end

	def make_a_move(box)
		@boxes_filled.push(box)
	end

end


game = Game.new


#when i move the looking to see if anyone has won out of turn it hangs at the end
