class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.20.0"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.0/terraphim_server-universal-apple-darwin"
    sha256 "0802634c35ab6bb3bca2b4ee09e2dd928483cae523f251ab97fb51cbfe8969c8"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.0/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "f8dd616fa4ffad5202b2242e19a0cea68a1d2c239c2c652d938192e1b94bb180"
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
