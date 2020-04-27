require 'faraday'
require 'figaro'
require 'pry'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  def self.find_neos_by_date(date)
    conn = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )
    asteroids_list_data = conn.get('/neo/rest/v1/feed')

    JSON.parse(asteroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
  end

  def self.largest_asteroid_diameter(date)
    self.find_neos_by_date(date).map do |asteroid|
      self.estimated_diameter(asteroid)
    end.max { |a,b| a<=> b}
  end

  def self.total_number_of_asteroids(date)
    self.find_neos_by_date(date).count
  end

  def self.estimated_diameter(asteroid, string = false)
    diameter = asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    string ? "#{diameter} ft" : diameter
  end

  def self.miss_distance(asteroid)
    distance = asteroid[:close_approach_data][0][:miss_distance][:miles].to_i
    "#{distance} miles"
  end

  def self.formatted_asteroid_data(date)
    self.find_neos_by_date(date).map do |asteroid|
      {
        name: asteroid[:name],
        diameter: self.estimated_diameter(asteroid, true),
        miss_distance: self.miss_distance(asteroid)
      }
    end
  end
  
end
