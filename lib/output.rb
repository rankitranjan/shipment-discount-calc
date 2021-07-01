# frozen_string_literal: true

require 'logger'

# Response for display it accepts message input and
# display on terminal as output.
module Output
  def display(message)
    @logger ||= Logger.new($stdout)
    @logger.formatter = proc { |_, _, _, msg| "#{msg}\n" }
    @logger.info(message)
  end

  def dispaly_output(input, output)
    output[1] = (output[1]).zero? ? '-' : format('%0.2f', output[1])
    output[0] = format('%0.2f', output[0])
    [input, output.join(' ')].join(' ')
  end

  def dispaly_error_output(input, output)
    [input, output].join(' ')
  end
end
