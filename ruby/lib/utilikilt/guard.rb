require 'guard'
require 'utilikilt/pipeline'

module Utilikilt
  class Guard
    def initialize(opts)
      @options = opts
    end

    def config 
      joined_exts = @options['input_file_exts'].join("|")
      input_regex = %r<[^/]+\.(#{joined_exts})$>
      <<-EOS
        OPTIONS = #{@options.inspect}
        guard 'shell' do
          watch(#{input_regex.inspect}) do |i|
            puts i.to_s+" changed"
            Utilikilt::Guard.handle_file_change(OPTIONS)
          end
        end
      EOS
    end

    def start
      ::Guard.setup
      ::Guard.start( :watchdir => @options['input_dir'], :guardfile_contents => config )
    end

    def self.handle_file_change(opts)
      print "pipelining..."
      pl = Utilikilt.pipeline(opts)
      print "..."
      pl.invoke
      puts " done!"
    end

  end
end
