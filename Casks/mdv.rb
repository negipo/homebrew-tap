cask "mdv" do
  version "2026.04.08.1"
  sha256 "530163da097d3f8e05a4d80b50257c32dd4793c9063eda288a3bd41f575dec26"

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
