class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.20.3"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.3/terraphim-agent-universal-apple-darwin"
    sha256 "27715a2dd31cecea1b94ffb9c1f49e1a9b8bf1dcbc3121074ca942c1a7be4a15"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.3/terraphim-agent-x86_64-unknown-linux-gnu"
    sha256 "312dba421f13356884438a9a00aaf863ac76b2d31c786924dbc6dff8c95fc6a5"
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
