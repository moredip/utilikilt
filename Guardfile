# A sample Guardfile
# More info at https://github.com/guard/guard#readme

#guard 'haml', :input => 'source', :output => 'public' do
  #watch(/^source\/.+(\.html\.haml)$/)
#end

guard 'rake', :task => 'guard_change' do
  watch(%r{^source\/.*$})
end
