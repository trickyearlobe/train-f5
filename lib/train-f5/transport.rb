# frozen_string_literal: true

require "train-f5/connection"

module TrainPlugins
  module F5
    # F5 Transport class for Train
    class Transport < Train.plugin(1)
      name "f5"
      option :host,     default: ENV["F5_HOST"]
      option :insecure, default: false
      option :user,     default: ENV["F5_USER"]
      option :port,     default: ENV["F5_PORT"] || "443"
      option :password, default: ENV["F5_PASSWORD"]

      # Returns a cached connection to an F5 BigIP appliance
      def connection(_instance_opts = nil)
        @connection ||= TrainPlugins::F5::Connection.new(@options)
      end
    end
  end
end
