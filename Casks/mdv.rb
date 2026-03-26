cask "mdv" do
  version "2026.03.26.3"
  sha256 "0d5b13f6db4ac19ed7a46c5fdf3ebfdafbd902e8b2e8c70da50cfe250f816fa8"

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
