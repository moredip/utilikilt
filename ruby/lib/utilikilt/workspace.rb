require 'pathname'

module Utilikilt
class Workspace
  def initialize base_dir, workspace_name
    @workspace_name = workspace_name
    @workspace_dir = Pathname.new(base_dir).join(@workspace_name).expand_path
  end

  def create_or_report_problems
    if @workspace_dir.directory?
      "There is already a directory called #{@workspace_name}. I don't want to mess with it. Please give me a new workspace name or delete that directory."
    elsif @workspace_dir.exist?
      "There is already a file called #{@workspace_name}, and I can't create a directory with the same name. Please give me a new workspace name or delete that file."
    else
      @workspace_dir.mkdir
      @workspace_dir.join(Utilikilt::DEFAULT_INPUT_DIR_NAME).mkdir
      @workspace_dir.join(Utilikilt::DEFAULT_OUTPUT_DIR_NAME).mkdir
      @workspace_dir.join(Utilikilt::DEFAULT_INPUT_DIR_NAME, 'index.haml').open('w') do |f|
        f.write CANNED_INDEX_HAML
      end
      nil
    end
  end


  CANNED_INDEX_HAML = <<EOS
!!! 5
%html
  %head
    %title
      Hello, world
  %body
    %p
      Welcome to your new workspace. Edit #{Utilikilt::DEFAULT_INPUT_DIR_NAME}/index.haml to get started.
EOS
end
end
