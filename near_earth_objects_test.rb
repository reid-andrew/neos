require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def test_a_date_returns_a_list_of_neos
    results = NearEarthObjects.find_neos_by_date('2019-03-30')

    assert_equal Array, results.class
    assert_equal 12, results.size
    assert_equal '(2019 GD4)', results[0][:name]
  end

  def test_it_calculates_largest_asteroid
    result = NearEarthObjects.largest_asteroid_diameter('2019-03-30')

    assert_equal 10233, result
  end

  def test_it_calculates_total_number_of_asteroids
    result = NearEarthObjects.total_number_of_asteroids('2019-03-30')

    assert_equal 12, result
  end

  def test_it_formats_estimated_diameter
    results = NearEarthObjects.find_neos_by_date('2019-03-30')

    assert_equal "61 ft", NearEarthObjects.estimated_diameter(results[0], true)
    assert_equal 61, NearEarthObjects.estimated_diameter(results[0], false)
  end

  def test_it_calculates_miss_distance
    results = NearEarthObjects.find_neos_by_date('2019-03-30')

    assert_equal "911947 miles", NearEarthObjects.miss_distance(results[0])
  end

  def test_it_formats_asteroid_data
    results = NearEarthObjects.formatted_asteroid_data('2019-03-30')

    assert_equal '(2019 GD4)', results[0][:name]
    assert_equal '61 ft', results[0][:diameter]
    assert_equal '911947 miles', results[0][:miss_distance]
  end

end
