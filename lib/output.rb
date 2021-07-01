# frozen_string_literal: true

require 'logger'

module Output
  def display(message)
    @logger ||= Logger.new($stdout)
    @logger.formatter = proc { |_, _, _, msg| "#{msg}\n" }
    @logger.info(message)
    return message
  end

  def dispaly_output(input, output)
    output[1] = (output[1]).zero? ? '-' : format('%0.2f', output[1])
    output[0] = format('%0.2f', output[0])
    return [input, output.join(' ')].join(' ')
  end

  def dispaly_error_output(input, output)
    return [input, output].join(' ')
  end
end
