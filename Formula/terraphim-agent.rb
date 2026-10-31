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
    macos: "72990af3f6288b605db9aa5280a76e51cb39ccbb1115f5600eec80f31eb20314",
    linux: on_arch_conditional(
      arm:   "36468a1ab4b3ee2f6781b623582a9044dc31768796a1a02b4d806fcc39dd6013",
      intel: "2f903a46c07a53ac2ded0a89c25a81b627b4b5f1599800b1b65ba4aff6192977",
    ),
  )
  url "https://downloads.terraphim.ai/terraphim-agent/terraphim-agent-1.21.22-#{target}.tar.gz"
  mirror "https://github.com/terraphim/terraphim-clients/releases/download/v1.21.22/terraphim-agent-1.21.22-#{target}.tar.gz"
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
