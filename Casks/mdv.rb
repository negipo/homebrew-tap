cask "mdv" do
  version "2026.10.30.1"
  sha256 "284896c65d7ef4fd44b4ef23278aaf7170008124e3441ce318816625bfc615f8"

  url "https://github.com/negipo/mdv/releases/download/v#{version}/mdv-#{version}-macos.dmg"
  name "mdv"
  desc "Markdown viewer"
  homepage "https://github.com/negipo/mdv"

  depends_on macos: :sonoma

  app "mdv.app"
  binary "#{appdir}/mdv.app/Contents/Resources/bin/mdv"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/mdv.app"]
  end

  zap trash: [
    "~/Library/Application Support/mdv",
    "~/Library/Caches/com.negipo.mdv",
    "~/Library/Preferences/com.negipo.mdv.plist",
  ]

  caveats <<~EOS
    mdv is not signed with an Apple Developer ID. The installer clears the
    quarantine attribute automatically so Gatekeeper will not block the app.
  EOS
end
