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
    macos: "90430cf2f3f70a7769e69c8941a196de1a6f8eb0a8dde387a78f5967ec123a8f",
    linux: on_arch_conditional(
      arm:   "1f4265ad8756378d101d35dc21d0362460cb858d9be99aa7486aafe83e8caa0f",
      intel: "2ea3704b3914b692e5afd11ac18f839263111a64a0db33b9df337d2b0f8b4932",
    ),
  )
  url "https://downloads.terraphim.ai/terraphim-agent/terraphim-agent-1.21.18-#{target}.tar.gz"
  mirror "https://github.com/terraphim/terraphim-clients/releases/download/v1.21.18/terraphim-agent-1.21.18-#{target}.tar.gz"
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
