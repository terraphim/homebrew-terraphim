class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.20.2"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.2/terraphim-agent-universal-apple-darwin"
    sha256 "db507281c66bd2432e6158ebb80a9eff5e8f92f565304004807d07d87d8b9aca"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.2/terraphim-agent-x86_64-unknown-linux-gnu"
    sha256 "0f0f448cd419238b99757a2bf97817a2ae1e39cfff8b63cf1cedd5aff9e62a45"
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
