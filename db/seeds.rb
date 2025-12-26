Follow.delete_all
Score.delete_all
Player.delete_all

# Buat players
players = %w[Alice Bob Charlie Diana Eve Frank Grace Hank Ivy]
players.each { |name| Player.create!(name: name) }

# Tambahkan 1-3 score acak untuk semua player
Player.all.each do |player|
  rand(1..3).times { Score.create!(player: player, value: rand(50..200)) }
end

# Beberapa follow relations
alice = Player.find_by(name: "Alice")
bob = Player.find_by(name: "Bob")
charlie = Player.find_by(name: "Charlie")
eve = Player.find_by(name: "Eve")
diana = Player.find_by(name: "Diana")

alice.active_follows.create(followed: bob)
alice.active_follows.create(followed: charlie)
eve.active_follows.create(followed: diana)
