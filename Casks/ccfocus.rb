cask "ccfocus" do
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/negipo/ccfocus/releases/download/v#{version}/ccfocus-#{version}-macos.dmg"
  name "ccfocus"
  desc "Menu bar app that tracks Claude Code sessions across Ghostty panes"
  homepage "https://github.com/negipo/ccfocus"

  depends_on macos: ">= :ventura"

  app "ccfocus-app.app"
  binary "#{appdir}/ccfocus-app.app/Contents/Resources/bin/ccfocus-logger"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ccfocus-app.app"],
                   sudo: false
    system_command "#{appdir}/ccfocus-app.app/Contents/Resources/bin/ccfocus-logger",
                   args: ["install"]
  end

  uninstall_preflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ccfocus-app.app"],
                   sudo: false
    system_command "#{appdir}/ccfocus-app.app/Contents/Resources/bin/ccfocus-logger",
                   args: ["uninstall"]
  end

  caveats <<~EOS
    ccfocus is not signed with an Apple Developer ID. The installer clears the
    quarantine attribute automatically so Gatekeeper will not block the app.

    Claude Code hooks are registered automatically into ~/.claude/settings.json.
    To start the menu bar app:
      open /Applications/ccfocus-app.app
  EOS

  zap trash: [
    "~/Library/Application Support/ccfocus",
    "~/Library/Preferences/com.negipo.ccfocus-app.plist",
    "~/Library/Caches/com.negipo.ccfocus-app",
  ]
end
