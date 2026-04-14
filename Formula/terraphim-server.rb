class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.34"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.34/terraphim_server-universal-apple-darwin"
    sha256 "23dcbf82e7c62503f030f14a48e7cd14c5a83569e2d043e57001e38a7e695de3"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.34/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "3209f2d3c90181523024686119fcfb9eb7cc76c6df81889f52b6c50692c3cef8"
  end

  def install
    if OS.mac?
      bin.install "terraphim_server-universal-apple-darwin" => "terraphim_server"
    else
      bin.install "terraphim_server-x86_64-unknown-linux-gnu" => "terraphim_server"
    end
  end

  service do
    run opt_bin/"terraphim_server"
    keep_alive true
    log_path var/"log/terraphim-server.log"
    error_log_path var/"log/terraphim-server-error.log"
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim_server --version 2>&1", 0)
  end
end
