# frozen_string_literal: true

class Point
  attr_reader :x, :y
  attr_accessor :cluster

  def initialize(x, y)
    @x = x
    @y = y

    @distance_cache = {}
  end

  def eql?(other)
    return false unless other.is_a? self.class

    @x == other.x && @y == other.y
  end

  def hash
    [@x, @y].hash
  end

  def distance_to(point)
    cached_value = cached_distance_to(point) || point.cached_distance_to(self)
    return cached_value unless cached_value.nil?

    Math.sqrt((point.x - @x)**2 + (point.y - @y)**2).tap do |distance|
      cache_distance point, distance
    end
  end

  def center?
    @cluster&.center == self
  end

  MAX_RAND_COORDINATE = 1000

  def self.rand
    x = Random.rand MAX_RAND_COORDINATE
    y = Random.rand MAX_RAND_COORDINATE

    Point.new x, y
  end

  protected

  def cached_distance_to(point)
    @distance_cache[point]
  end

  def cache_distance(point, value)
    @distance_cache[point] = value
  end
end
