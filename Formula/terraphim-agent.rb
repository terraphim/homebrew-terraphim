class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"

  target = on_system_conditional(
    macos: "universal-apple-darwin",
    linux: on_arch_conditional(
      arm:   "aarch64-unknown-linux-musl",
      intel: "x86_64-unknown-linux-gnu",
    ),
  )
  checksum = on_system_conditional(
    macos: "324db55c1713b98f9b7db2723848c26f5ae7dfb8f960ab50e1549b1b865eafaa",
    linux: on_arch_conditional(
      arm:   "01eb9e7626947abcd93b616a37cd8c09de08f5849dc8a9bbd4710cf08adb87e1",
      intel: "bee43ce0f53b001f3e12e23c0a90b6ece6f7b132fe9299147665174df11e15e5",
    ),
  )
  url "https://github.com/terraphim/terraphim-ai/releases/download/v1.21.3/terraphim-agent-#{target}"
  version "1.21.3"
  sha256 checksum
  license "Apache-2.0"

  def install
    binary = if OS.mac?
      "terraphim-agent-universal-apple-darwin"
    elsif Hardware::CPU.arm?
      "terraphim-agent-aarch64-unknown-linux-musl"
    else
      "terraphim-agent-x86_64-unknown-linux-gnu"
    end
    bin.install binary => "terraphim-agent"
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim-agent --version 2>&1")
  end
end
