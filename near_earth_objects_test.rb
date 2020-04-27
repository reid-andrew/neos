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


end
