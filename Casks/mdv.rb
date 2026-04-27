cask "mdv" do
  version "2026.04.27.1"
  sha256 "580d474628a249b2be5c77019d47d8431b25b2e6199f30da88060b834a94ab29"

  url "https://github.com/negipo/mdv/releases/download/v#{version}/mdv-#{version}-macos.dmg"
  name "mdv"
  desc "Markdown viewer for macOS"
  homepage "https://github.com/negipo/mdv"

  depends_on macos: ">= :sonoma"

  app "mdv.app"
  binary "#{appdir}/mdv.app/Contents/Resources/bin/mdv"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/mdv.app"],
                   sudo: false
  end

  caveats <<~EOS
    mdv is not signed with an Apple Developer ID. The installer clears the
    quarantine attribute automatically so Gatekeeper will not block the app.
  EOS

  zap trash: [
    "~/Library/Application Support/mdv",
    "~/Library/Preferences/com.negipo.mdv.plist",
    "~/Library/Caches/com.negipo.mdv",
  ]
end
