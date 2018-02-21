class StatsController < ApplicationController

  def index
    response = HTTParty.get('https://api.mysportsfeeds.com/v1.2/pull/nhl/current/cumulative_player_stats.json', headers: { 'Authorization' => "Basic #{ENV['MSF_KEY']}"})


    @nhl_current_stats = []

    response.parsed_response["cumulativeplayerstats"]["playerstatsentry"].each do |entry|
      @nhl_current_stats << { player_firstname: entry["player"]["FirstName"],
                              player_lastname: entry["player"]["LastName"],
                              team: entry["team"]["Name"],
                              stats: { games_played: entry["stats"]["GamesPlayed"]["\#text"],
                                       goals: entry["stats"]["stats"]["Goals"]["\#text"] }
                            }
    end


    respond_to do |format|
      format.json do
        render json: { games: @games }
      end
      format.html do
        render :index
      end
    end
  end
end
