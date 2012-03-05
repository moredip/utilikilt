module Utilikilt
  def pipeline_for_dir( dir ) 
    input_dir = File.join( 'dir','source')
    output_dir = File.join( 'dir','public')
    Rake::Pipeline.build do
      input input_dir, "**/*.haml"
      output output

      filter(Rake::Pipeline::Web::Filters::TiltFilter) do |input|
        input.sub(/\.haml$/, '.html')
      end
    end
  end
end
