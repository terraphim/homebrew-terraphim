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
    macos: "c00c3c6270cca93c31861e2e85395b21c71c97179e178260a9f6129bd93e34bc",
    linux: on_arch_conditional(
      arm:   "aa9881a85bf1227462c79c8c370e9506128575f9a7077267db0c67141b0d900b",
      intel: "e45652a3e3763a976945b1a43a7ca2336f64d8db94aa8bd67633c7cfaf4b0627",
    ),
  )
  url "https://downloads.terraphim.ai/terraphim-agent/terraphim-agent-1.21.14-#{target}.tar.gz"
  mirror "https://github.com/terraphim/terraphim-clients/releases/download/v1.21.14/terraphim-agent-1.21.14-#{target}.tar.gz"
  sha256 checksum
  license "Apache-2.0"

  def install
    bin.install "terraphim-agent"
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim-agent --version 2>&1")
    assert_match "Learning capture", shell_output("#{bin}/terraphim-agent learn --help 2>&1")
    assert_match "Memory lifecycle", shell_output("#{bin}/terraphim-agent memory --help 2>&1")
    assert_match "Print the full body", shell_output("#{bin}/terraphim-agent sessions expand --help 2>&1")
    if OS.mac?
      system "/usr/bin/codesign", "--verify", "--all-architectures", "--deep", "--strict",
             bin/"terraphim-agent"
    end
  end
end
