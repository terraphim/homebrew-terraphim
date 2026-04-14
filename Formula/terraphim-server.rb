class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.34"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.34/terraphim_server-universal-apple-darwin"
    sha256 "0656aa22de67847117d4246a4eb5bd648302b93c57cee94c36d624faa173a1a9"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.34/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "cf916119fab4935025b292097132b0e03cf31fb5c91250358bf8302700b49213"
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
