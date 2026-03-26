cask "mdv" do
  version "2026.03.26.4"
  sha256 "7edb04bf02fb5a35ae8fedba4284abbf295371a597fceb2a29070f48cbdb02ac"

  url "https://github.com/negipo/mdv/releases/download/v#{version}/mdv-#{version}-macos.dmg"
  name "mdv"
  desc "Markdown viewer for macOS"
  homepage "https://github.com/negipo/mdv"

  depends_on macos: ">= :sonoma"

  app "mdv.app"
  binary "#{appdir}/mdv.app/Contents/Resources/bin/mdv"

  caveats <<~EOS
    mdv is not signed with an Apple Developer ID.
    After installation, run the following to remove the quarantine attribute:
      xattr -dr com.apple.quarantine /Applications/mdv.app
  EOS

  zap trash: [
    "~/Library/Application Support/mdv",
    "~/Library/Preferences/com.negipo.mdv.plist",
    "~/Library/Caches/com.negipo.mdv",
  ]
end
