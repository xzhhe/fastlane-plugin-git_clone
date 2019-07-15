describe Fastlane::Actions::GitCloneAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The git_clone plugin is working!")

      Fastlane::Actions::GitCloneAction.run(nil)
    end
  end
end
