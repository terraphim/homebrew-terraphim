class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.33"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.33/terraphim_server-universal-apple-darwin"
    sha256 "2a28f1f94b70d51d1af9a3998f537691f8176e3e2bbca6acb7dcc77d2276ace4"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.33/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "cba6fc6352a7a07d042b30a098ea6c870befe0e1b948ac8c1ecc53e2302501a8"
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
