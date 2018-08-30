module Fastlane
  module Actions
    class TeamsAction < Action
      def self.run(params)
        require 'net/http'
        require 'uri'

        payload = {
          "@type" => "MessageCard", 
          "@context" => "http://schema.org/extensions",
          "themeColor" => params[:theme_color],
          "title" => params[:title],
          "summary" => params[:title],
          "sections" => [ { "text" => params[:message], "facts" => params[:facts] } ]
        }

        json_headers = { 'Content-Type' => 'application/json' }
        uri = URI.parse(params[:teams_url])
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        response = http.post(uri.path, payload.to_json, json_headers)

        check_response_code(response)
      end

      def self.check_response_code(response)
        if response.code.to_i == 200 && response.body.to_i == 1
          true
        else
          UI.user_error!("An error occurred: #{response.body}")
        end
      end

      def self.description
        "Send a message to your Microsoft Teams channel via the webhook connector"
      end

      def self.authors
        ["mbogh"]
      end

      def self.details
        "Send a message to your Microsoft Teams channel"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :title,
                                       env_name: "FL_TEAMS_TITLE",
                                       description: "The title that should be displayed on Teams"),
          FastlaneCore::ConfigItem.new(key: :message,
                                       env_name: "FL_TEAMS_MESSAGE",
                                       description: "The message that should be displayed on Teams. This supports the standard Teams markup language"),
          FastlaneCore::ConfigItem.new(key: :facts,
                                       type: Array,
                                       env_name: "FL_TEAMS_FACTS",
                                       description: "Optional facts"),
          FastlaneCore::ConfigItem.new(key: :teams_url,
                                       env_name: "FL_TEAMS_URL",
                                       sensitive: true,
                                       description: "Create an Incoming WebHook for your Teams channel",
                                       verify_block: proc do |value|
                                         UI.user_error!("Invalid URL, must start with https://") unless value.start_with? "https://"
                                       end),
          FastlaneCore::ConfigItem.new(key: :theme_color,
                                       env_name: "FL_TEAMS_THEME_COLOR",
                                       description: "Theme color of the message card",
                                       default_value: "0078D7")
        ]
      end

      def self.example_code
        [
          'teams(
            title: "Fastlane says hello",
            message: "App successfully released!",
            facts:[
              {
                "name"=>"Platform",
                "value"=>"Android
              },
              {
                "name"=>"Lane",
                "value"=>"android internal"
              }
            ],
            teams_url: "https://outlook.office.com/webhook/..."
          )'
        ]
      end

      def self.category
        :notifications
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
