class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.20.2"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.2/terraphim_server-universal-apple-darwin"
    sha256 "c2a9bee091fb5bdffa4813e3d561e63501832cb0a792793fc05664033fd95167"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.2/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "78f4f73212c2ec570154bd8931cf07cd1f772f1032e7ebd47b40923dcc577954"
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
