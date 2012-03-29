require 'thor'
require 'utilikilt/guard'
require 'utilikilt/scanner'
require 'utilikilt/node_proxy'

module Utilikilt
  class CLI < Thor
    #desc "up", "serve up everything in public, with live refresh"
    #def up
      #puts "UTILIKILT! UP!"
    #end

    desc "watch", "watch for changes to source files and automatically create corresponding public files"
    method_option :input_dir, :aliases => '-i', :type => 'string'
    method_option :output_dir, :aliases => '-o', :type => 'string'
    method_option :project_dir, :aliases => '-p', :type => 'string'
    def watch()
      opts = normalize_options(options)
      opts['input_file_exts'] = Utilikilt::INPUT_FILE_EXTS 
      start_guard( opts ) 
    end

    desc "build", "rebuild all input files"
    method_option :input_dir, :aliases => '-i', :type => 'string'
    method_option :output_dir, :aliases => '-o', :type => 'string'
    method_option :project_dir, :aliases => '-p', :type => 'string'
    def build()
      opts = normalize_options(options)
      run_one_off_scan( opts ) 
    end

    desc "serve", "Start a little web server host whatever is in your public directory, with live refresh"
    def serve( project_dir=nil )
      start_serve( normalize_project_dir(project_dir) )
    end

    desc "up", "live-compile the contents of source, and serve it up to your browser with live-refresh"
    def up( project_dir=nil )
      project_dir = normalize_project_dir(project_dir)
      guard_thread = Thread.new{ start_guard(:project_dir => project_dir) }
      serve_thread = Thread.new{ start_serve(project_dir) }

      serve_thread.join # joining on serve rather than guard is arbitrary
    end

    private 

    def start_guard(options)
      Utilikilt::Guard.new(options).start
    end

    def run_one_off_scan(options)
      scanner = Scanner.new( options )
      scanner.scan
    end

    def start_serve(project_dir)
      server = Utilikilt::NodeProxy.new

      problems = server.check_prereqs_and_advise
      if problems
        puts problems
        exit 1
      end

      server.launch_server
    end


    def normalize_options( opts )
      normalized = {}
      %w{project_dir input_dir output_dir}.each do |k|
        normalized[k] = File.expand_path( opts[k] ) if opts.has_key?(k)
      end

      normalized['project_dir'] = Dir.getwd unless opts.has_key?( 'project_dir' )
      normalized['input_dir'] ||= File.join( normalized['project_dir'], 'source' )
      normalized['output_dir'] ||= File.join( normalized['project_dir'], 'public' )

      normalized
    end

    def normalize_project_dir( project_dir )
      project_dir = project_dir ? File.expand_path(project_dir) : Dir.getwd
    end
  end
end
