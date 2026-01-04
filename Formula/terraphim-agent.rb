class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.4.0"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.4.0/terraphim-agent-universal-apple-darwin"
    sha256 "484b856e1259dfc87e6c47a13e2b77180ac0be32ed91e8c9bca8584b393a8a38"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.4.0/terraphim-agent-x86_64-unknown-linux-gnu"
    sha256 "c7d7a5bf01685c1eed2cf3bf024e35f5abc5152d28bb0dfa0bb158de6c17b5e8"
  end

  def install
    if OS.mac?
      bin.install "terraphim-agent-universal-apple-darwin" => "terraphim-agent"
    else
      bin.install "terraphim-agent-x86_64-unknown-linux-gnu" => "terraphim-agent"
    end
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
