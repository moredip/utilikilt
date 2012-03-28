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
  INPUT_FILE_EXTS = %w{haml md markdown}

  def self.pipeline( opts )
    input_dir = opts['input_dir']
    output_dir = opts['output_dir']

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
