# frozen_string_literal: true

require "train"

# Allow us to raise F5 specific exceptions
module TrainPlugins
  module F5
    class Error < Train::Error; end
  end
end
