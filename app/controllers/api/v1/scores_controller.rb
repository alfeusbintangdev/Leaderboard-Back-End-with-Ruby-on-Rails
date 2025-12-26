module Api
  module V1
    class ScoresController < ApplicationController
      # POST /api/v1/scores
      def create
        player = Player.find_or_create_by(name: params[:player_name])
        score = player.scores.create(value: params[:score])

        render json: { message: "Score submitted successfully", score: score }
      end

      # GET /api/v1/scores/leaderboard
      def leaderboard
        scores = Score
          .joins(:player)
          .select("players.id AS player_id, players.name, MAX(scores.value) AS score")
          .group("players.id, players.name")
          .order("score DESC")
          .limit(10)

        render json: scores.map { |s|
          {
            player_id: s.player_id,
            name: s.name,
            score: s.score.to_i
          }
        }
      end
    end
  end
end
