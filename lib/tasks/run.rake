# frozen_string_literal: true

require_relative '../../transaction'
require_relative '../../lib/process_file'

task :run do
  desc 'run transaction to parse the input file'
  file = ARGV[1..-1][0]
  abort('Args Error: Provide input file to process') if file.nil?
  abort('File not found') if !File.file?(file)
  ReadInputFile.start(file)
end

class ReadInputFile
  include ProcessFile

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def self.start(file)
    new(file).process
  end

  def process
    Transaction.start(read_file(file))
  end
end
