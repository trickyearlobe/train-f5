# frozen_string_literal: true

require "train"
require "train-f5/version"
require "train-f5/error"
require "faraday"
require "faraday_middleware"

module TrainPlugins
  module F5
    # F5 Connection
    class Connection < Train::Plugins::Transport::BaseConnection
      # Initialise Faraday as the HTTP handler with basic auth
      # and automatic JSON conversion.
      def initialize(options)
        super(options)
        @baseurl = "https://#{options[:host]}:#{options[:port]}"
        @httpclient = Faraday.new(
          url: @baseurl, ssl: { verify: !options[:insecure] },
          headers: { "Content-Type" => "application/json", "Accept" => "application/json" }
        ) do |conn|
          if Faraday::VERSION.split(".")[0] == "1"
            conn.request :basic_auth, options[:user], options[:password]
          else
            conn.request :authorization, :basic, options[:user], options[:password]
          end
          conn.request :json
        end
      end

      # Allow Train to query the platform we are connected to
      def platform
        body = get("/mgmt/tm/sys/version")
        f5_release = body["entries"].values[0]["nestedStats"]["entries"]["Version"]["description"]
        # f5_family = body['entries'].values[0]['nestedStats']['entries']['Product']['description']
        Train::Platforms.name("f5").in_family("api")
        force_platform!("f5", release: f5_release)
      end

      # Do GET,PUT,POST, DELETE with the cached Faraday client
      def get(uri)
        process_response(@httpclient.get(uri))
      end

      def put(uri, data = nil)
        process_response(@httpclient.put(uri, data))
      end

      def post(uri, data = nil)
        process_response(@httpclient.post(uri, data))
      end

      def delete(uri)
        process_response(@httpclient.delete(uri))
      end

      def process_response(resp)
        JSON.parse(resp.body)
      end
    end
  end
end
