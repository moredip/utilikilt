require 'guard'

module Utilikilt
  module Guard
    CONFIG = <<-EOS
      guard 'shell' do
        watch(%r{^source\/.*$}) do
          Utilikilt::Guard.handle_file_change
        end
      end
    EOS

    def self.start
      ::Guard.setup
      ::Guard.start(:guardfile_contents => CONFIG)
    end

    def self.handle_file_change
      puts 'stuff changed'
    end

  end
end
