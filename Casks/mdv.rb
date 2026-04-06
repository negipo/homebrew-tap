cask "mdv" do
  version "2026.04.06.2"
  sha256 "b7b68a8def9142c630ed392695d00812ae5b6ebf8fd52b9148ccdcef2a82ef60"

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
