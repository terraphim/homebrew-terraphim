class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.37"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.37/terraphim_server-universal-apple-darwin"
    sha256 "bfaf3fd8ab8fe7b2c6159f61cbf0685a889a3c428b1d6686c31f78dd3b8e3de9"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.37/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "fdef068c92b78c0fe2dcfa8f05de920cdf4ee2da7f8b5e4fc8a076391feb0934"
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
