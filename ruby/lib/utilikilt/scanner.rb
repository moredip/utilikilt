require 'pathname'
require 'fileutils'

require 'utilikilt/loggable'

module Utilikilt
class Scanner
  include Loggable

  def initialize( opts )
    @input_base = Pathname.new( opts['input_dir'] ).expand_path
    @output_base = Pathname.new( opts['output_dir'] ).expand_path
    @files_processed = 0
  end
  
  INPUT_TO_OUTPUT_EXT_MAP = {
    'md' => 'html',
    'markdown' => 'html',
    'haml' => 'html',
    'sass' => 'css',
    'scss' => 'css',
    'coffee' => 'js'
  }

  TILT_OPTIONS = {:cache => false}

  def scan
    @files_processed = 0
    input_file_glob = '*.{'+INPUT_TO_OUTPUT_EXT_MAP.keys.join(',')+'}'
    Pathname.glob(File.join( @input_base, "**", input_file_glob )).each do |input|
      debug{"checking #{input}"} 
      output = output_for_input(input)
      unless FileUtils.uptodate?( output, [input] ) 
        filter( input, output )
      end
    end

    log_files_processed
  end

  private

  def log_files_processed
    puts "#{@files_processed} files processed"
  end

  def filter input, output
    require 'tilt'

    output.dirname.mkpath

    print "#{input} => #{output} ... "
      template = Tilt.new( input.to_s, 1, TILT_OPTIONS )

      output.dirname.mkpath
      output.open('w') do |out_file|
        out_file.write( template.render )
      end
    puts " done"

    @files_processed += 1
  end

  def output_for_input input
    relative = input.relative_path_from @input_base
    
    # this is a bit fiddly because Pathname defines exts as including the leading dot while our map does not include it
    output_ext = '.'+INPUT_TO_OUTPUT_EXT_MAP[input.extname[1..-1]]

    raise ArgumentError, "unrecognized input file extension for #{input}" if output_ext.nil?

    @output_base.join( relative.sub_ext(output_ext) )
  end

end
end
