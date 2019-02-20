# frozen_string_literal: true

class Cluster
  attr_accessor :center

  def initialize(center, max_points_length = 10)
    @center = center

    init_points max_points_length
  end

  def clear
    @points_count = 0

    add @center
  end

  def add(point)
    @points[@points_count]  = point
    @points_count          += 1

    point.cluster = self
  end

  def distance_to(point)
    @center.distance_to point
  end

  def points
    @points[0...@points_count]
  end

  private

  def init_points(max_len)
    @points       = Array.new max_len
    @points_count = 0

    add @center
  end
end
