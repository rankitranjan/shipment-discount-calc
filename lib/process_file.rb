# frozen_string_literal: true

# This ProcessFile module keeps the helper methods of file.
module ProcessFile
  def read_file(path = nil)
    File.open(path || self.class::INPUT_FILE_PATH)
  end

  def extract_values(line)
    line.match(self.class::PATTERN).captures
  end

  def valid?(line)
    line =~ self.class::PATTERN
  end
end
