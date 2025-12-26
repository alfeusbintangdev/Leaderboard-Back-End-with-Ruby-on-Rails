module Api
  module V1
    class PlayersController < ApplicationController
      def follow
        follower = Player.find(params[:id])
        followed = Player.find(params[:followed_id])

        follower.following << followed unless follower.following.include?(followed)

        render json: { message: "Followed successfully" }
      end

      def unfollow
        follower = Player.find(params[:id])
        followed = Player.find(params[:followed_id])

        follower.following.delete(followed)

        render json: { message: "Unfollowed successfully" }
      end

      def following_leaderboard
        player = Player.find(params[:id])

        scores = Score
          .joins(:player)
          .where(player: player.following)
          .select("players.id AS player_id, players.name, MAX(scores.value) AS score")
          .group("players.id, players.name")
          .order("score DESC")

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
