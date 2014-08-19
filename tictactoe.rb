class TicTacToe
	def initialize
		gameboard = Board.new
		players = Players.new		
		gameboard.display_board
		game_on(gameboard,players)
	end
	
	def player_o_move(gameboard, player_o)
		moved = false
		until moved == true do
			puts "#{player_o}'s turn! Choose your move!"
			move = (gets.chomp.to_i - 1)
			if gameboard[move][:o] == false || gameboard[move][:x] == false
				gameboard[move][:o] = true
				moved = true
			else 
				puts "That's not a valid move."
			end
		end
	end
	
	def player_x_move(gameboard, player_x)
		moved = false
		until moved == true do
			puts "#{player_x}'s turn! Choose your move!"
			move = (gets.chomp.to_i - 1)
			if gameboard[move][:o] == false || gameboard[move][:x] == false
				gameboard[move][:x] = true
				moved = true
			else 
				puts "That's not a valid move."
			end
		end
	end
	
	def game_on(gameboard, players)
		puts "#{players.player_x} goes first!"
		loop do
			player_x_move(gameboard.board,players.player_x)			
			gameboard.display_board	
			break if gameboard.win_check?(:x) || gameboard.win_check?(:o) == true 
			break if gameboard.tie_check?		
			player_o_move(gameboard.board,players.player_o)			
			gameboard.display_board
			break if gameboard.win_check?(:x) || gameboard.win_check?(:o) == true 							
			break if gameboard.tie_check?
		end
	end
	
	class Board
		attr_accessor :board
		def initialize						
			@board = create_board
		end
		
		def create_board			
			board = []
			y = 1
			3.times do
				i = 1
				3.times do board.push(create_boardspace)
					i += 1
				end
				y += 1
			end
			board
		end
		
		def create_boardspace
			boardspace = {:x=> false, :o=> false}
		end
		
		def display_board
			@board.each_with_index do |boardspace,i|
				if boardspace[:x] == true
					print "#{i+1}.X"
				elsif boardspace[:o] == true
					print "#{i+1}.O"
				else print "#{i+1}._"
				end			
				if (i+1) % 3 == 0
					puts " "
				else
					print " "
				end
			end
		end
		
		def win_check?(side)
			win = false
			win_check = win_sets(side)
			win_check.each do |set|
				if set.all? {|space| space == true}
					win = true
					break
				end
			end
			puts "#{side.to_s} wins!" if win == true
			win
		end
		
		def win_sets(side)
			sets = [[@board[0][side],@board[1][side],@board[2][side]],
				   [@board[3][side],@board[4][side],@board[5][side]],
				   [@board[6][side],@board[7][side],@board[8][side]],
				   [@board[0][side],@board[3][side],@board[6][side]],
				   [@board[1][side],@board[4][side],@board[7][side]],
				   [@board[2][side],@board[5][side],@board[8][side]],
				   [@board[0][side],@board[4][side],@board[8][side]],
				   [@board[2][side],@board[4][side],@board[6][side]]]
		end
		
		def tie_check?
			tie = false
			i = 0
			@board.each do |space|
				i += 1 if space[:x] == true || space[:o] == true
			end
			tie = true if i == 9
			puts "A tie!" if tie == true
			tie
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