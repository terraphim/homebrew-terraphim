class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.11"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.11/terraphim_server-universal-apple-darwin"
    sha256 "098cf3ead19c840abe4d3f553ac17d364be0053f81a08859373e594cad51109f"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.11/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "LINUX_SHA_PLACEHOLDER"
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
