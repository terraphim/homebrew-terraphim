class TerraphimAgent < Formula
  desc "Interactive TUI and REPL for Terraphim AI semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.5.2"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.5.2/terraphim-agent-universal-apple-darwin"
    sha256 "3cba3cec16b8b8e2d374ad6014b11c988967e7cedc9c0cab8272f0f89b204033"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.5.2/terraphim-agent-x86_64-unknown-linux-gnu"
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
