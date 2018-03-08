class ScoresController < ApplicationController
  def index
    date = '20180307'
    response_nhl = HTTParty.get('https://api.mysportsfeeds.com/v1.2/pull/nhl/current/scoreboard.json?fordate='+ date, headers: { 'Authorization' => "Basic #{ENV['MSF_KEY']}"})

    @scores = []

    response_nhl.parsed_response['scoreboard']['gameScore'].each do |game|
      @scores << { id: game['game']['ID'], date: game['game']['date'], awayteam: game['game']['awayTeam']['Name'], awayteam_city: game['game']['awayTeam']['City'], hometeam: game['game']['homeTeam']['Name'], hometeam_city: game['game']['homeTeam']['City'], location: game['game']['location'], away_score: game['awayScore'], home_score: game['homeScore']  }
    end
  end
end
