# tricks rubygems into believeing that the extension compiled and worked out.
# This function lifted straight out of the zerg_support gem https://rubygems.org/gems/zerg_support
def emulate_extension_install
  extension_name = "utilikilt"
  File.open('Makefile', 'w') { |f| f.write "all:\n\ninstall:\n\n" }
  File.open('make', 'w') do |f|
    f.write '#!/bin/sh'
    f.chmod f.stat.mode | 0111
  end
  File.open(extension_name + '.so', 'w') {}
  File.open(extension_name + '.dll', 'w') {}
  File.open('nmake.bat', 'w') { |f| }
end


def executable?( exe )
  system "command -v #{exe} >/dev/null 2>&1"
end

def check_prereqs_and_advise
  return nil if executable? 'node'

  generic_advice = "\nUtilikilt uses node.js to serve up your files, but you don't appear to have it installed.\n"
  if executable? 'brew'
    return [generic_advice,"However it does look like you have homebrew available.","To install node simply run `brew install node`, then try to install the utilikilt gem again."].join("\n")
  elsif `uname` =~ /Darwin/
    return [generic_advice,%Q{The easiest way to install node is using a package manager called homebrew. You can get started with homebrew by visting http://bit.ly/getbrew, or just run the following from the command line:},%Q{/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"},"",%Q{Once homebrew is installed you can install node.js with a simple `brew install node` from the command line. After that, try installing the utilikilt gem again.}].join("\n")
  else
    return [generic_advice,"Please install node.js and then try to install the utilikilt gem again."].join("\n")
  end
end


def install_node_package
  puts 'installing utilikilt npm package...'
  system *%w{npm install utilikilt}, {:chdir => "../../"}
  puts '...utilikilt npm package installed'
end

# This is a big ol' hack to run a pre-install script for this gem, by pretending to compile a native extension. See http://blog.costan.us/2008/11/post-install-post-update-scripts-for.html for details.

emulate_extension_install()

prereq_errors = check_prereqs_and_advise()
if prereq_errors
  puts "\n\n\n"
  puts "*"*80
  puts prereq_errors
  puts "*"*80
  puts "\n\n\n"
  exit 1
end

install_node_package()


