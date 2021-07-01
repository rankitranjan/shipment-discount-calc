# frozen_string_literal: true

module ProcessFile
  def read_file(path=nil)
    File.open(path || self.class::INPUT_FILE_PATH)
  end

  def extract_values(line)
    line.match(self.class::PATTERN).captures
  end

  def valid?(line)
    line =~ self.class::PATTERN
  end
end
