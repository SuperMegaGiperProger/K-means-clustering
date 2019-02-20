# frozen_string_literal: true

class PointView
  POINT_SIZE = 7

  def initialize(point)
    @point = point
  end

  def render(painter)
    painter.drawRect @point.x, @point.y, POINT_SIZE, POINT_SIZE
  end
end
