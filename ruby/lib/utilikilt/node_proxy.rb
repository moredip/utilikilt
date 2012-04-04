module Utilikilt
  class NodeProxy
    NODE_DIR = File.join( File.dirname(__FILE__), '..','..', 'node_modules', 'utilikilt' )

    def initialize( serve_dir )
      @serve_dir = File.expand_path(serve_dir)
    end

    def launch_server
      system 'node_modules/.bin/coffee', 'lib/uk.coffee', @serve_dir, {:chdir => NODE_DIR}
    end
  end
end
