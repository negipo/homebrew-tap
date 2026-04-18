cask "ccfocus" do
  version "2026.04.18.1"
  sha256 "b65de484e2c08f6b03a0f7e95197d106d217619515d767b9007c50448961d280"

  url "https://github.com/negipo/ccfocus/releases/download/v#{version}/ccfocus-#{version}-macos.dmg"
  name "ccfocus"
  desc "Menu bar app that tracks Claude Code sessions across Ghostty panes"
  homepage "https://github.com/negipo/ccfocus"

  depends_on macos: ">= :ventura"

  app "ccfocus.app"
  binary "#{appdir}/ccfocus.app/Contents/Resources/bin/ccfocus-logger"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ccfocus.app"],
                   sudo: false
    system_command "#{appdir}/ccfocus.app/Contents/Resources/bin/ccfocus-logger",
                   args: ["install"]
  end

  uninstall_preflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ccfocus.app"],
                   sudo: false
    system_command "#{appdir}/ccfocus.app/Contents/Resources/bin/ccfocus-logger",
                   args: ["uninstall"]
  end

  zap trash: [
    "~/Library/Application Support/ccfocus",
    "~/Library/Caches/com.negipo.ccfocus",
    "~/Library/Preferences/com.negipo.ccfocus.plist",
  ]

  caveats <<~EOS
    ccfocus is not signed with an Apple Developer ID. The installer clears the
    quarantine attribute automatically so Gatekeeper will not block the app.

    Claude Code hooks are registered automatically into ~/.claude/settings.json.
    To start the menu bar app:
      open /Applications/ccfocus.app
  EOS
end
