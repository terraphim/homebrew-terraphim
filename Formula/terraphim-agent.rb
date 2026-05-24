class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.20.0"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.0/terraphim-agent-universal-apple-darwin"
    sha256 "20ef8a02835d12491d66254e26ed973e25398785b7d2301d926c83f82bd71a99"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.0/terraphim-agent-x86_64-unknown-linux-gnu"
    sha256 "db888e2f963c86583dcd6717109b18517412a58aedf82bb7d6e44a93b8135866"
  end

  def install
    if OS.mac?
      bin.install "terraphim-agent-universal-apple-darwin" => "terraphim-agent"
    else
      bin.install "terraphim-agent-x86_64-unknown-linux-gnu" => "terraphim-agent"
    end
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim-agent --version 2>&1", 0)
  end
end
