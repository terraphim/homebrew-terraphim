class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.10"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.10/terraphim-agent-universal-apple-darwin"
    sha256 "d55fa24de0b8d7c1db8305c7e9e38872d49e973af91bc88f2963b0076d8433ad"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.10/terraphim-agent-x86_64-unknown-linux-gnu"
    sha256 "LINUX_SHA_PLACEHOLDER"
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
