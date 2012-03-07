require 'thor'
require 'utilikilt/guard'
require 'utilikilt/node_proxy'

module Utilikilt
  class CLI < Thor
    #desc "up", "serve up everything in public, with live refresh"
    #def up
      #puts "UTILIKILT! UP!"
    #end

    desc "watch", "watch for changes to source files and automatically create corresponding public files"
    def watch( project_dir=nil )
      project_dir = normalize_project_dir(project_dir)

      Utilikilt::Guard.new(project_dir).start
    end

    desc "serve", "Start a little web server host whatever is in your public directory, with live refresh"
    def serve( project_dir=nil )
      project_dir = normalize_project_dir(project_dir)
      
      server = Utilikilt::NodeProxy.new

      problems = server.check_prereqs_and_advise
      if problems
        puts problems
        exit 1
      end

      server.launch_server
    end
    
    private 

    def normalize_project_dir( project_dir )
      project_dir = project_dir ? File.expand_path(project_dir) : Dir.getwd
    end
  end
end
