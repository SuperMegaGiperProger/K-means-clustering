# frozen_string_literal: true

class KMeansService
  def initialize(points, clusters)
    @points   = points
    @clusters = clusters
  end

  def call
    loop do
      any_point_changed = false

      update_point = proc do |point, cluster|
        any_point_changed = true

        yield point, cluster if block_given?
      end

      update_clusters_points(&update_point)
      update_clusters_centres(&update_point)

      break unless any_point_changed
    end

    @clusters
  end

  private

  def update_clusters_points
    @clusters.each(&:clear)

    @points.each do |point|
      next if point.center?

      cluster = @clusters.min { |a, b| a.distance_to(point) <=> b.distance_to(point) }

      changed = point.cluster != cluster

      cluster.add point

      yield point, cluster if block_given? && changed
    end
  end

  def update_clusters_centres
    @clusters.each do |cluster|
      new_center = cluster.points.min_by do |center|
        cluster.points.map { |point| point.distance_to(center) }.max
      end

      next if cluster.center == new_center

      cluster.center = new_center

      yield new_center, cluster if block_given?
    end
  end
end
