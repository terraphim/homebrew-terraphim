class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.34"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.34/terraphim-agent-universal-apple-darwin"
    sha256 "f629f2731e02955ae243da054b9d18633d8ba901e6a78b69bd43cc7510b5e703"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.34/terraphim-agent-x86_64-unknown-linux-gnu"
    sha256 "ded8d5cd19e4199b5cd834138d1186d85d8cc34fd51b0a18626825cdf3580d92"
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
