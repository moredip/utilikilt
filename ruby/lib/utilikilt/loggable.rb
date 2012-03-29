module Utilikilt::Loggable
  def debug
    puts yield if $DEBUG
  end
end

