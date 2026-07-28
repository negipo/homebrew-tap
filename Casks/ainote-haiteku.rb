cask "ainote-haiteku" do
  version "2026.06.01.1"
  sha256 "0e27a9a555af5be428c80caa8d9038ab71a5d6147851e28d7ee31cc72ea99112"

  url "https://github.com/negipo/ainote-haiteku/releases/download/v#{version}/ainote-haiteku-#{version}-macos.dmg"
  name "ainote-haiteku"
  desc "Menu bar app that plays ainote sounds unless a Google Meet tab is open"
  homepage "https://github.com/negipo/ainote-haiteku"

  depends_on macos: :sonoma

  app "ainote-haiteku.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ainote-haiteku.app"],
                   sudo: false
  end

  caveats <<~EOS
    ainote-haiteku is not signed with an Apple Developer ID. The installer clears
    the quarantine attribute automatically so Gatekeeper will not block the app.

    On first launch, grant the following under System Settings > Privacy & Security:
      - Accessibility (to observe key presses)
      - Automation > Google Chrome (to detect open Google Meet tabs)
  EOS

  zap trash: [
    "~/Library/Preferences/com.negipo.ainote-haiteku.plist",
  ]
end
