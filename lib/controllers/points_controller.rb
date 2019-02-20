# frozen_string_literal: true

require 'views/points_field.rb'
require 'models/point.rb'
require 'models/cluster.rb'
require 'services/k_means_service.rb'

class PointsController
  def initialize
    @points   = []
    @clusters = []
  end

  def init_random_points(count)
    @points = Array.new(count) { Point.rand }
  end

  def init_random_clusters(count)
    @clusters = Array.new(count) { Cluster.new @points.sample, @points.length }
  end

  def render
    PointsField.render @clusters
  end

  def cluster
    @clusters = KMeansService.new(@points, @clusters).call
  end
end
