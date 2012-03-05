require 'thor'
require 'utilikilt/guard'

module Utilikilt
  class CLI < Thor
    #desc "up", "serve up everything in public, with live refresh"
    #def up
      #puts "UTILIKILT! UP!"
    #end

    desc "watch", "watch for changes to source files and automatically create corresponding public files"
    def watch( project_dir )
      project_dir = project_dir ? File.expand_path(project_dir) : Dir.getwd

      Utilikilt::Guard.new(project_dir).start
    end
  end
end
