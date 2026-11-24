cask "mechvibes" do
  arch arm:   "arm64",
       intel: "x86_64"

  version "3.5.11"
  sha256  arm:   "84dc0b0de73c2a1cbde77ed1db479033ebd01f0e2abb1e0d402277a9a9964ce4",
          intel: "d1567047379c0174136c281e0d6e966a4fcb3b1e5b1823c3e39e848c956871b3"

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
