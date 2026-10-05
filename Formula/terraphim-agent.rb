class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-clients"

  target = on_system_conditional(
    macos: "universal-apple-darwin",
    linux: on_arch_conditional(
      arm:   "aarch64-unknown-linux-musl",
      intel: "x86_64-unknown-linux-gnu",
    ),
  )
  checksum = on_system_conditional(
    macos: "6ce1da8af996da33e1f3f0e1aa68267a84c2c744c93e0b05d15045241f7f62f8",
    linux: on_arch_conditional(
      arm:   "310588b3c86e1cb9df85f4ecb43b4b2de13bc69aaf672f8608240fee92eaa164",
      intel: "99d5734aa47fe34bed4d16ecc7d3de9422700b0be62ce6082f5fb18768de9192",
    ),
  )
  url "https://downloads.terraphim.ai/terraphim-agent/terraphim-agent-1.21.17-#{target}.tar.gz"
  mirror "https://github.com/terraphim/terraphim-clients/releases/download/v1.21.17/terraphim-agent-1.21.17-#{target}.tar.gz"
  sha256 checksum
  license "Apache-2.0"

  def install
    bin.install "terraphim-agent"
    # Marks this keg as Homebrew-managed so `terraphim-agent update` defers to
    # `brew upgrade` instead of overwriting the Cellar binary.
    (share/"terraphim/package-manager.d").mkpath
    (share/"terraphim/package-manager.d"/"terraphim-agent").write "homebrew\n"
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim-agent --version 2>&1")
    assert_equal "homebrew\n", (share/"terraphim/package-manager.d"/"terraphim-agent").read
    assert_match "Learning capture", shell_output("#{bin}/terraphim-agent learn --help 2>&1")
    assert_match "Session management", shell_output("#{bin}/terraphim-agent sessions --help 2>&1")
    if OS.mac?
      system "/usr/bin/codesign", "--verify", "--all-architectures", "--deep", "--strict",
             bin/"terraphim-agent"
    end
  end
end
