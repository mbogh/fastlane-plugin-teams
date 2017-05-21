describe Fastlane::Actions::TeamsAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The teams plugin is working!")

      Fastlane::Actions::TeamsAction.run(nil)
    end
  end
end
