class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.9"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.9/terraphim-agent-universal-apple-darwin"
    sha256 "d5909a9d22a36a6efdf538b3320d336bf4e7821f718f999c0db43ec5123da495"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.9/terraphim-agent-x86_64-unknown-linux-gnu"
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
