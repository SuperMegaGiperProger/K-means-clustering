# frozen_string_literal: true

lib_path = File.expand_path('./lib', __dir__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require 'controllers/points_controller.rb'

points_count   = ARGV[0].to_i
clusters_count = ARGV[1].to_i

points_controller = PointsController.new

points_controller.init_random_points   points_count
points_controller.init_random_clusters clusters_count

points_controller.cluster

points_controller.render
