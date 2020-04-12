
require_relative 'player'
# require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'

class Game

	attr_reader :title

	def initialize(title)
		@title = title.capitalize
		@players = []
	end

	def add_player(a_player)
		@players.push(a_player)
		# # OR ..Alternative way below
		# @players<<a_player
	end

	def play(rounds)

		#puts "Game Type: #{@title.upcase}:"
		puts "\nThere Are #{@players.size} Players in #{@title}:"

		@players.each do |player|
			puts player
		end

		treasures = TreasureTrove::TREASURES
		puts "\nThere are #{treasures.size} treasures to be found:"

			treasures.each do |t|
			puts "A #{t.name} is worth #{t.points} points"
			end
			
		1.upto(rounds) do |round|
			puts "\nRound #{round}:"
			if block_given?
				break if yield
			end
			@players.each do |player|
				GameTurn.take_turn(player)
				puts player	
			end
		end
	end

	def print_name_and_health(player)
		puts "#{player.name} (#{player.health})"
	end

	def high_score_entry (player)
      formatted_name = player.name.ljust(20,'.')
      "#{formatted_name} #{player.score}"
	end

	def total_points
		 @players.reduce(0) { |sum, player| sum + player.points } 
		# OR Alternative below..
		# @players.reduce(0) do |sum, player| 
		#  sum + player.points	
	end


	def print_stats
		puts "\n#{@title} statistics:"

		strong_players, wimpy_players = @players.partition {|player| player.strong?}

		
		
		puts "\n#{strong_players.size} Strong Players:"
		strong_players.each do |player|
			print_name_and_health(player)
		end
		
		puts "\n#{wimpy_players.size} Wimpy Players:"
		wimpy_players.each do |player|
			print_name_and_health(player)	
		end

		puts "\n#{@title} High Scores:"
		@players.sort.each do  |player|	
			puts high_score_entry (player)
		end

		puts "\n#{total_points} total points from treasures found:"	

		@players.sort.each do |player|
			puts "\n#{player.name}'s point totals:"

			player.each_found_treasure do |treasure|
			puts "#{treasure.points} total #{treasure.name} points"
			end
			puts "#{player.points} grand total points"	
		end		
	end

	def load_players(from_file)
		File.readlines(from_file).each do |line|	
		add_player(Player.from_csv(line))
		end
	end

	def save_high_scores(to_file="high_scores.text")
		File.open(to_file, "w") do |file|
			file.puts "#{@title} High Scores:"
			@players.sort.each do |player|
			file.puts high_score_entry (player)
			end
		end
	end
end

