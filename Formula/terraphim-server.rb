class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.16.34"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.34/terraphim_server-universal-apple-darwin"
    sha256 "fccf2e2cf4d5e3b7ed07d4e832c63f5d89cbe3d5f105ca2a152f39b6bbcfc9f5"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.16.34/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "ff40420028fb5d66894f9ade1ca0245de05a8b1ec35fd1c6d76aa781c50df34c"
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
