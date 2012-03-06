require 'haml'
require 'redcarpet'
require 'tilt'

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

module Utilikilt
  def self.pipeline_for_dir( dir ) 
    input_dir = File.join( dir,'source')
    output_dir = File.join( dir,'public')
    Rake::Pipeline.build do
      input input_dir, "**/*"
      output output_dir

      match "*.haml" do
        filter(Rake::Pipeline::Web::Filters::TiltFilter) do |input|
          input.sub(/\.haml$/, '.html')
        end
      end

      match "*.{md,markdown}" do
        filter(Rake::Pipeline::Web::Filters::TiltFilter) do |input|
          input.sub(/\.(md|markdown)$/, '.html')
        end
      end

    end
  end
end
