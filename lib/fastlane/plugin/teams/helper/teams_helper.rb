module Fastlane
  module Helper
    class TeamsHelper
      # class methods that you define here become available in your action
      # as `Helper::TeamsHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the teams plugin helper!")
      end
    end
  end
end
