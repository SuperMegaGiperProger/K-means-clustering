# frozen_string_literal: true

require 'Qt'
require 'models/point.rb'
require 'views/cluster_view.rb'

class PointsField < Qt::Widget
  def initialize(clusters)
    super()

    setWindowTitle 'K-means Visualization'
    resize Point::MAX_RAND_COORDINATE, Point::MAX_RAND_COORDINATE

    @clusters = clusters
  end

  def self.render(clusters)
    app = Qt::Application.new []

    window = new(clusters)
    window.show

    app.exec
  end

  # rubocop:disable Naming/MethodName
  def paintEvent(_event)
    painter = Qt::Painter.new self

    @clusters.each { |cluster| ClusterView.new(cluster).render(painter) }

    painter.end
  end
  # rubocop:enable Naming/MethodName
end
