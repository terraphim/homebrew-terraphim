class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  url "https://github.com/terraphim/terraphim-ai/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "48a6d07139bab943993c4535cb970aa64169ddfb91072d6f655e295f0d229233"
  license "Apache-2.0"
  head "https://github.com/terraphim/terraphim-ai.git", branch: "main"

  depends_on "rust" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl@3"

  def install
    system "cargo", "build", "--release", "--package", "terraphim_agent", "--features", "repl-full"
    bin.install "target/release/terraphim-agent"
  end

  def caveats
    <<~EOS
      Terraphim Agent (TUI) has been installed.

      To start the interactive REPL:
        terraphim-agent

      Available commands in REPL:
        /help           - Show all commands
        /search "query" - Semantic search
        /chat "message" - AI conversation
        /commands list  - List available markdown commands
    EOS
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim-agent --version 2>&1", 0)
  end
end
