class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.33"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.33/terraphim-agent-universal-apple-darwin"
    sha256 "b52180c4b80bb359ed62ee9c4fbd302282c612eb668683ce122819b934270f4d"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.33/terraphim-agent-x86_64-unknown-linux-gnu"
    sha256 "caa1afb6d286cb675c2ad67d7f84928fad5235120cd615c23a45d1fea088a23f"
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
