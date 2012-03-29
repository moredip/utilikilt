require 'rb-fsevent'

module Utilikilt
class Watcher
  def self.watch( dir_to_watch, &handler )
    Watcher.new( dir_to_watch, handler ).start_watching
  end

  def initialize( dir_to_watch, on_change_handler )
    @fsevent = FSEvent.new
    @fsevent.watch dir_to_watch do |directories|
      on_change_handler.call( directories )
    end
  end
  
  def start_watching
    @fsevent.run
  end
end
end
