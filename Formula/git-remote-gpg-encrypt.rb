class GitRemoteGpgEncrypt < Formula
  desc "Transparent, passphrase-only, encrypted git backups via a git remote helper"
  homepage "https://vraravam.github.io/git-remote-gpg-encrypt/"
  url "https://github.com/vraravam/git-remote-gpg-encrypt.git",
      tag:      "v0.1.1",
      revision: "ab1b15ad320815af3f1d49a9e52b5c43d18ad260"
  license "MIT"

  # git is the other hard runtime dependency (this tool IS a git remote helper,
  # invoked directly by git itself for 'gpg-encrypt::' remotes). Declared explicitly
  # even though Homebrew itself requires git to be present, for correctness and to
  # protect against minimal/CI environments that might not otherwise guarantee it.
  depends_on "git"

  # gpg --symmetric is the actual encryption backend this tool is built around (see
  # that repo's docs/DESIGN.md for why gpg was chosen over age) -- every command this
  # formula installs is broken without it, so it is a hard runtime dependency, not
  # merely something documented in the README.
  depends_on "gnupg"

  # No 'depends_on "ruby"': this tool uses only Ruby's standard library (zero gems at
  # runtime -- see the main repo's Gemfile) and targets Ruby >= 2.6, which macOS ships
  # by default. Pulling in Homebrew's full Ruby formula would be unnecessary weight
  # for a tool this small.

  def install
    # Install only the runtime artifacts (bin/ + lib/), not the whole repo (tests,
    # CI config, docs) -- keeps the Cellar entry lean. Installing both under libexec
    # together preserves their relative layout, so bin/*'s
    # 'require_relative "../lib/git_remote_gpg_encrypt"' resolves correctly.
    libexec.install "bin", "lib"

    bin.install_symlink libexec/"bin/git-remote-gpg-encrypt"
    bin.install_symlink libexec/"bin/git-gpg-encrypt-setup"
    bin.install_symlink libexec/"bin/git-gpg-encrypt-verify"
    bin.install_symlink libexec/"bin/git-gpg-encrypt-restore"
  end

  test do
    assert_match "Usage: git gpg-encrypt-setup", shell_output("#{bin}/git-gpg-encrypt-setup --help")
    assert_match "Usage: git gpg-encrypt-verify", shell_output("#{bin}/git-gpg-encrypt-verify --help")
    assert_match "Usage: git gpg-encrypt-restore", shell_output("#{bin}/git-gpg-encrypt-restore --help")
    assert_path_exists bin/"git-remote-gpg-encrypt"
  end
end
