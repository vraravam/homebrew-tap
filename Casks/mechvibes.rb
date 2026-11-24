cask "mechvibes" do
  arch arm:   "arm64",
       intel: "x86_64"

  version "3.5.9"
  sha256  arm:   "ddbc3b4e1c1535deac46d645d0735c6aa77d713c66c2ecdcb7c2f5d74ca93c27",
          intel: "52fa731f3ef2b9f514757b66d76b66a2a3153a15c8fe489c199098a1416eb2be"

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
