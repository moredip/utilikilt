require 'guard'
require 'utilikilt/pipeline'

module Utilikilt
  class Guard
    def initialize(project_dir)
      @project_dir = project_dir
    end

    def config 
      <<-EOS
        PROJECT_DIR = #{@project_dir.inspect}
        guard 'shell' do
          watch(%r{^source\/[^\.].*$}) do |i|
            Utilikilt::Guard.handle_file_change_for_dir(PROJECT_DIR)
          end
        end
      EOS
    end

    def start
      ::Guard.setup
      ::Guard.start( :watchdir => @project_dir, :guardfile_contents => config )
    end

    def self.handle_file_change_for_dir(project_dir)
      print "pipelining..."
      Utilikilt.pipeline_for_dir(project_dir).invoke
      puts " done!"
    end

  end
end
