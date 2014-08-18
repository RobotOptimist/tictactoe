class TicTacToe
	def initialize
		gameboard = Board.new
		display_board(gameboard.board)
	end
	
	def player_o_move
	end
	
	def player_x_move
	end
	
	def display_board(gameboard)
		gameboard.each_with_index do |boardspace,i|
			if boardspace[:x] == true
				print "X"
			elsif boardspace[:o] == true
				print "O"
			else print "_"
			end			
			if (i+1) % 3 == 0
				puts " "
			else
				print " "
			end
		end
	end
	
	def win_check?(gameboard)
		win = false
		if gameboard[5][:x] == true && gameboard[1][:x]== true && gameboard[9][:x]== true
			win = true
		elsif gameboard[5][:x] == true && gameboard[2][:x]== true && gameboard[8][:x]== true
			win = true
		elsif gameboard[5][:x] == true && gameboard[4][:x]== true && gameboard[6][:x]== true
			win = true
		elsif gameboard[5][:x] == true && gameboard[3][:x]== true && gameboard[7][:x]== true
			win = true
		elsif gameboard[1][:x] == true && gameboard[2][:x]== true && gameboard[3][:x]== true
			win = true
		elsif gameboard[1][:x] == true && gameboard[4][:x]== true && gameboard[7][:x]== true
			win = true
		elsif gameboard[7][:x] == true && gameboard[8][:x]== true && gameboard[9][:x]== true
			win = true
		elsif gameboard[3][:x] == true && gameboard[6][:x]== true && gameboard[9][:x]== true
			win = true
		else "No winner yet"
		end
		win
	end
	
	class Board
		attr_reader :board
		def initialize						
			@board = create_board
		end
		
		private
		
		def create_board			
			board = []
			y = 1
			3.times do
				i = 1
				3.times do board.push(create_boardspace(y,i))
					i += 1
				end
				y += 1
			end
			board
		end
		
		def create_boardspace(row,column)
			boardspace = {:row => row, :column => column, :x=> false, :o=> false}
		end
	end
	
	class Players
		attr_reader :player_x, :player_o
		def initialize
			players
		end
		
		private
		
		def players
			print "Who is the first player today?"
			first_player = gets.chomp
			print "Who is the second player today?"
			second_player = gets.chomp
			position(first_player,second_player)
		end
		
		def position(first_player,second_player)
			print "Will you play x or o?"
			choice = gets.chomp
			choice_complete = false
			until choice_complete == true do
				if choice == "x"
					puts "#{first_player} is x! guess that means you're o, #{second_player}"
					@player_x = first_player
					@player_o = second_player
					choice_complete = true
				elsif choice == "o"
					puts "#{first_player} is o! guess that means you're x, #{second_player}"
					@player_o = first_player
					@player_x = second_player
					choice_complete = true
				else puts "That's not a valid choice!"
				end
			end
		end		
	end
end

game = TicTacToe.new