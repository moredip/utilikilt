module Utilikilt
  class NodeProxy
    NODE_DIR = File.join( File.dirname(__FILE__), '..','..', 'node_modules', 'utilikilt' )

    def initialize( serve_dir )
      @serve_dir = File.expand_path(serve_dir)
    end

    # returns nil if all pre-requisites are present
    # otherwise returns a string describing next steps to resolving
    # pre-requisites
    def check_prereqs_and_advise
      return nil if executable? 'node'

      generic_advice = "\nUtilikilt uses node.js to serve up your files, but you don't appear to have it installed.\n"
      if executable? 'brew'
        return [generic_advice,"However it does look like you have homebrew available.","To install node simply run `brew install node`, then try again."].join("\n")
      elsif `uname` =~ /Darwin/
        return [generic_advice,%Q{The easiest way to install node is using a package manager called homebrew. You can get started with homebrew by visting http://bit.ly/getbrew, or just run the following from the command line:},%Q{/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"},"",%Q{Once homebrew is installed you can install node.js with a simple `brew install node` from the command line}].join("\n")
      else
        return [generic_advice,"Please install node.js and then try again."].join("\n")
      end
    end

    def launch_server
      system 'node_modules/.bin/coffee', 'lib/uk.coffee', @serve_dir, {:chdir => NODE_DIR}
    end

    private
    def executable?( exe )
      system "command -v #{exe} >/dev/null 2>&1"
    end
  end
end
