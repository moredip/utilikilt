require 'thor'
require 'utilikilt/scanner'
require 'utilikilt/watcher'
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
    def watch( project_dir = nil )
      opts = normalize_options(project_dir,options)
      start_watcher(opts)
    end

    desc "build", "rebuild all input files"
    method_option :input_dir, :aliases => '-i', :type => 'string'
    method_option :output_dir, :aliases => '-o', :type => 'string'
    def build( project_dir = nil )
      opts = normalize_options(project_dir,options)
      run_one_off_scan( opts ) 
    end

    desc "serve", "Start a little web server host whatever is in your public directory, with live refresh"
    def serve( project_dir = nil )
      opts = normalize_options(project_dir,options)
      start_serve( opts )
    end

    desc "up", "live-compile the contents of source, and serve it up to your browser with live-refresh"
    method_option :input_dir, :aliases => '-i', :type => 'string'
    method_option :output_dir, :aliases => '-o', :type => 'string'
    def up( project_dir=nil )
      watch_thread = Thread.new{ watch(project_dir) }
      serve_thread = Thread.new{ serve(project_dir) }

      serve_thread.join # joining on serve rather than watch is arbitrary
    end

    private 

    def run_one_off_scan(options)
      scanner = Scanner.new( options )
      scanner.scan
    end

    def start_watcher(options)
      scanner = Scanner.new( options )
      Watcher.watch options['input_dir'] do
        scanner.scan
      end
    end

    def start_serve(options)
      server = Utilikilt::NodeProxy.new( options['output_dir'] )

      problems = server.check_prereqs_and_advise
      if problems
        puts problems
        exit 1
      end

      server.launch_server
    end


    def normalize_options( project_dir, opts )
      normalized = {}
      %w{input_dir output_dir}.each do |k|
        normalized[k] = File.expand_path( opts[k] ) if opts.has_key?(k)
      end
      normalized['project_dir'] = File.expand_path( project_dir || Dir.getwd )

      normalized['input_dir'] ||= File.join( normalized['project_dir'], 'source' )
      normalized['output_dir'] ||= File.join( normalized['project_dir'], 'public' )

      normalized
    end
  end
end
