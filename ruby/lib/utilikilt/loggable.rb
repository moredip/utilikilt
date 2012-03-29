module Utilikilt
module Loggable
  def debug
    puts yield if $DEBUG
  end
end
end

