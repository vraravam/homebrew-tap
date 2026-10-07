cask "wobbly" do
  version "0.1.1"
  sha256 "45c52c2b47d08ae5628111069d289bb53995a65680a40989802707bedb6473c9"

  url "https://github.com/jsgrrchg/Wobbly/releases/download/v#{version}/Wobbly-#{version}.dmg"
  name "Wobbly"
  desc "Compiz-style wobbly windows"
  homepage "https://github.com/jsgrrchg/Wobbly"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Wobbly.app"

  # The app is signed with a development certificate but not notarized, so
  # Gatekeeper refuses to open the quarantined copy Homebrew downloads (the user
  # would have to go to System Settings > Privacy & Security > Open Anyway).
  # Clearing the quarantine flag does that once. Only this one app bundle is
  # touched, and the command succeeds whether or not the flag is present.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Wobbly.app"]
  end

  zap trash: [
    "~/Library/Caches/io.github.jsgrrchg.Wobbly",
    "~/Library/Preferences/io.github.jsgrrchg.Wobbly.plist",
  ]

  caveats <<~EOS
    Wobbly needs two macOS permissions. Enable it under
    System Settings > Privacy & Security, in both:
      - Accessibility (to watch mouse events and move windows)
      - Screen Recording (to capture the dragged window; without it, windows move rigidly)

    Wobbly is a menu bar app and has no Dock icon.
  EOS
end
