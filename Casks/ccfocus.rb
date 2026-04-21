cask "ccfocus" do
  version "2026.04.21.1"
  sha256 "9f55715b9cc4a47cfce04a3d4336c29876302dd74e35f41918fe24ce01105a08"

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
