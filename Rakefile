require 'haml'
require 'rake-pipeline'
module Rake
  class Pipeline
    module Web
      module Filters
      end
    end
  end
end
require 'rake-pipeline-web-filters/tilt_filter'

SOURCE_DIR = File.join( File.dirname(__FILE__), 'source' )
PUBLIC_DIR = File.join( File.dirname(__FILE__), 'public' )

#FileList.new(File.join(SOURCE_DIR,'**','*.haml')).each do |haml_file|
  #p haml_file
#end

task :default do
end


pipeline = Rake::Pipeline.build do
  input SOURCE_DIR, "**/*.haml"
  output PUBLIC_DIR

  filter(Rake::Pipeline::Web::Filters::TiltFilter) do |input|
    input.sub(/\.haml$/, '.html')
  end
end

task :pipeline do
  pipeline.invoke
end

task :guard_change => :pipeline