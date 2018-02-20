class SchedulesController < ApplicationController
  def index
    response = HTTParty.get('https://api.mysportsfeeds.com/v1.2/pull/nhl/current/full_game_schedule.json?team=tor', headers: { 'Authorization' => "Basic #{ENV['MSF_KEY']}"})

    @schedules = []
    @games = []

    response.parsed_response['fullgameschedule']['gameentry'].each do |game|
      @games << { id: game['id'], date: game['date'], awayteam: game['awayTeam']['Name'], hometeam: game['homeTeam']['Name'] }
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
