class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.37"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.37/terraphim-agent-universal-apple-darwin"
    sha256 "097239f6016326712fc1dcae76034af4a15080b3d1f944d168f51b262517e24e"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.37/terraphim-agent-x86_64-unknown-linux-gnu"
    sha256 "57d116f2aeafde9a45b86987abbba1de51a8a20c77165865fa90485e6c81ac50"
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
