module Calcium
  def format(number)
    ("%g" % number.round(4)).match(/^-?\d+(?:\.\d{1,4})?/).not_nil![0]
  end
end
