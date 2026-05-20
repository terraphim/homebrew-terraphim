class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.19.3"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.19.3/terraphim-agent-universal-apple-darwin"
    sha256 "0f3db394a79a7e87b8028932d788b46fe0641439ce1e8df9798860158b1f8dd7"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.19.3/terraphim-agent-x86_64-unknown-linux-gnu"
    sha256 "c04472704db63214a8a2740e311e9b82c6f2a4d46a9e2f0bc9aa176daa2058fb"
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
