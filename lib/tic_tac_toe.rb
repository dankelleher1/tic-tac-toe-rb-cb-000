WIN_COMBINATIONS = [
   [0, 1, 2], # Top row
   [3, 4, 5], # Middle row
   [6, 7, 8], # Bottom row
   [0, 3, 6], # Left column
   [1, 4, 7], # Middle column
   [2, 5, 8], # Right column
   [0, 4, 8], # Diagonal Top-Left -> Bottom-Right
   [2, 4, 6] # Diagonal Top-right -> Bottom-Left
 ]
  
 def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
 end

 def input_to_index(input)
   return input.to_i - 1
 end
 
 def move(board, index, token)
   board[index] = token
 end
 
def position_taken?(board, index)
   !(board[index].nil? || board[index] == " ")
 end

 def valid_move?(board, index)
   if(index.between?(0, 8) && !position_taken?(board, index))
     return true
   else
     return false
   end
 end
 
 def turn(board)
   puts "Please enter 1-9:"
   input = gets.strip
   index = input_to_index(input)
 
   if !valid_move?(board, index)
     turn(board)
   else
     move(board, index, current_player(board))
     display_board(board)
   end
 end
 
 def turn_count(board)
   counter = 0
 
   board.each do |item|
     if(item == "X" || item == "O")
       counter += 1
     end
   end
 
   return counter
 end
 
 def current_player(board)
   turn_count(board).even? ? "X" : "O"
 end
 
 
 def won?(board)
   WIN_COMBINATIONS.each do |win_combination|
     win_index_1 = win_combination[0]
     win_index_2 = win_combination[1]
     win_index_3 = win_combination[2]
 
     position_1 = board[win_index_1]
     position_2 = board[win_index_2]
     position_3 = board[win_index_3]
 
     if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
       return win_combination
     end
   end
   
   return false
 end
 
 def full?(board)
   board.all? { |i| i == "X" || i == "O" }
 end
 
 def draw?(board)
   if (!won?(board) && full?(board))
     return true
   else
     return false
   end
 end
 
 def over?(board)
   if(won?(board) || draw?(board) || full?(board))
     return true
   end
 end
 
 def winner(board)
   board[won?(board)[0]] if won?(board)
 end
 
 def play(board)
   while(!over?(board))
     turn(board)
   end
   
   if(won?(board))
     puts "Congratulations #{winner(board)}!"
   elsif(draw?(board))
     puts "Cats Game!"
   end
 end
