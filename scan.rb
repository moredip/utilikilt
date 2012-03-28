require 'pathname'
require 'fileutils'


INPUT_BASE = Pathname.new( "source" ).expand_path
OUTPUT_BASE = Pathname.new( "public" ).expand_path

INPUT_TO_OUTPUT_EXT_MAP = {
  'md' => 'html',
  'markdown' => 'html',
  'haml' => 'html',
  'sass' => 'css',
  'scss' => 'css',
  'coffee' => 'js'
}

def filter input, output
  require 'tilt'

  print "#{input} => #{output} ... "
    template = Tilt.new( input.to_s )
    File.open( output, 'w' ) do |out_file|
      out_file.write( template.render )
    end
  puts " done"
end

def output_for_input input
  relative = input.relative_path_from INPUT_BASE
  
  # this is a bit fiddly because Pathname defines exts as including the leading dot while our map does not include it
  output_ext = '.'+INPUT_TO_OUTPUT_EXT_MAP[input.extname[1..-1]]

  raise ArgumentError, "unrecognized input file extension for #{input}" if output_ext.nil?

  File.join( OUTPUT_BASE, relative.sub_ext(output_ext) )
end

input_file_glob = '*.{'+INPUT_TO_OUTPUT_EXT_MAP.keys.join(',')+'}'
Pathname.glob(File.join( INPUT_BASE, "**", input_file_glob )).each do |input|
  output = output_for_input(input)
  unless FileUtils.uptodate?( output, [input] ) 
    filter( input, output )
  end
end
