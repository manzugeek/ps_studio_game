require_relative 'player'
require_relative 'game'
require_relative 'clumsy_player'
require_relative 'berserk_player'

player1 = Player.new("moe")
player2 = Player.new("larry", 60)
player3 = Player.new("curly", 125)

knuckleheads = Game.new("knuckleheads")
# knuckleheads.add_player(player1)
# knuckleheads.add_player(player2)
# knuckleheads.add_player(player3)
# klutz = ClumsyPlayer.new("klutz", 105)
# knuckleheads.add_player(klutz)

berserker = BerserkPlayer.new("berserker", 50)
knuckleheads.add_player(berserker)

knuckleheads.load_players(ARGV.shift || "players.csv")
# knuckleheads.play(2) do
# knuckleheads.total_points >= 2000
# end
# knuckleheads.print_stats

loop do
	puts "\nHow many game rounds? ('quit' to exit)"
	answer = gets.chomp.downcase 

	case answer
	when /^\d+$/
		knuckleheads.play(answer.to_i)
	when 'quit', 'exit'
		knuckleheads.print_stats
		break
	else
		puts "Please enter a number or quit"
	end
	knuckleheads.save_high_scores
end


# dandahead = Game.new("dandahead")
# dandahead.add_player(player2)
# dandahead.play(2)

# salsa = Game.new("salsa")
# player4 = Player.new("shamim", 19)
# salsa.add_player(player4)
# salsa.play(2)
# salsa.print_stats
























