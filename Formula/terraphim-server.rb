class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.20.3"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.3/terraphim_server-universal-apple-darwin"
    sha256 "6c807b3221b5b1c3a3b5308f7bce1f16ab5d8e48d8bf07769c8fa1473cea678e"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.3/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "df1514d5e20c1f5d91046ad7fd0bffec1fabfdcc1d7418582edd4c9534d05968"
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
