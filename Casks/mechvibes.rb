cask "mechvibes" do
  arch arm:   "arm64",
       intel: "x86_64"

  version "3.5.6"
  sha256  arm:   "cb1279567f3530f85a14ecde35bb1c5692a7addee5da895a7213681860e277d7",
          intel: "cf91c0a080b9a054f672d81b23198c28ef1e5f01bfb015d7428f5638c0344b8e"

  url "https://github.com/hainguyents13/mechvibes/releases/download/v#{version}/mechvibes-#{version}-macos-#{arch}.dmg"
  name "Mechvibes"
  desc "Play mechanical keyboard sounds as you type"
  homepage "https://mechvibes.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Mechvibes.app"

  # The app is ad-hoc signed but not notarized, so Gatekeeper refuses to open the
  # quarantined copy Homebrew downloads (a plain double-click is blocked and the
  # user would have to right-click > Open). Clearing the quarantine flag is what
  # that right-click does, once. Only this one app bundle is touched, and the
  # command succeeds whether or not the flag is present.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Mechvibes.app"]
  end

  zap trash: "~/Library/Application Support/Mechvibes"

  caveats <<~EOS
    Mechvibes needs two macOS permissions to hear your keystrokes. Enable it under
    System Settings > Privacy & Security, in both:
      - Accessibility (while its window is focused)
      - Input Monitoring (while it is minimized or another app is in front)

    The app is ad-hoc signed, so after an upgrade macOS can keep showing those
    permissions as on while they have stopped working. If the keys go silent, reset
    them and grant them again:
      tccutil reset Accessibility com.hainguyents13.mechvibes
      tccutil reset ListenEvent com.hainguyents13.mechvibes
  EOS
end
