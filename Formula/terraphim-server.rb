class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.33"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.33/terraphim_server-universal-apple-darwin"
    sha256 "a2a670bfba5a43777759033fac10ea70c15feada8abf0dbd3b5827e0b5b74cad"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.33/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "4b6aee920f92a27fd387af1b8695f2e5221dceac20d5e0c8dbbd209da5a464d8"
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
