cask "mechvibes-dx" do
  version "0.9.1"
  sha256 "79ecfdeba4cbfb2a7ca56f560b8917862421a25c77d8385724b295c4c3281f06"

  url "https://github.com/vraravam/mechvibes-dx/releases/download/v#{version}/mechvibes-dx-#{version}-macos-arm64.dmg"
  name "MechvibesDX"
  desc "Mechanical keyboard and mouse sound simulator"
  homepage "https://github.com/vraravam/mechvibes-dx"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The release ships an Apple Silicon build only (see the DMG's name).
  depends_on arch: :arm64
  depends_on :macos

  app "MechvibesDX.app"

  # The app is ad-hoc signed but not notarized, so Gatekeeper refuses to open the
  # quarantined copy Homebrew downloads (a plain double-click is blocked and the
  # user would have to right-click > Open). Clearing the quarantine flag is what
  # that right-click does, once. Only this one app bundle is touched, and the
  # command succeeds whether or not the flag is present.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MechvibesDX.app"]
  end

  zap trash: "~/Library/Application Support/Mechvibes"

  caveats <<~EOS
    MechvibesDX needs two macOS permissions to hear your keystrokes. Enable it under
    System Settings > Privacy & Security, in both:
      - Accessibility (while its window is focused)
      - Input Monitoring (while it is minimized or another app is in front)

    The app is ad-hoc signed, so after an upgrade macOS can keep showing those
    permissions as on while they have stopped working. If the keys go silent, reset
    them and grant them again:
      tccutil reset Accessibility com.hainguyents13.mechvibesdx
      tccutil reset ListenEvent com.hainguyents13.mechvibesdx
  EOS
end
