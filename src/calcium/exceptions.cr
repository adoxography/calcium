module Calcium
  class CalciumException < Exception
  end

  class TokenizeException < CalciumException
  end

  class ParseException < CalciumException
  end

  class CalculateException < CalciumException
  end
end
