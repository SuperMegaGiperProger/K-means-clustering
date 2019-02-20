# frozen_string_literal: true

require 'views/point_view.rb'

class ClusterView
  def initialize(cluster)
    @cluster = cluster
  end

  def render(painter)
    render_points painter
    render_center painter
  end

  private

  def render_points(painter)
    painter.setPen Qt::NoPen
    painter.setBrush Qt::Brush.new(rand_color)

    @cluster.points.each { |point| PointView.new(point).render(painter) }
  end

  CENTER_POINT_COLOR        = Qt::Color.new 255, 0, 0
  CENTER_POINT_BORDER_COLOR = Qt::Color.new 0, 0, 0
  DEFAULT_POINT_OPACITY     = 250

  def render_center(painter)
    painter.setPen   CENTER_POINT_BORDER_COLOR
    painter.setBrush Qt::Brush.new(CENTER_POINT_COLOR)

    PointView.new(@cluster.center).render(painter)
  end

  def rand_color
    Qt::Color.new Random.rand(255), Random.rand(255), Random.rand(255), DEFAULT_POINT_OPACITY
  end
end
