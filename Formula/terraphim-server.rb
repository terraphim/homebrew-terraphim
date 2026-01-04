class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.4.0"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.4.0/terraphim_server-universal-apple-darwin"
    sha256 "001b33efba176e9e419c41f08fa508590ecf6a070ff6cf7effe8eb10f330c336"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.4.0/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "ae21177b73f48c3391a3f434dc84e1d65e8092a6e3f04e2a34580187fd147759"
  end

  def install
    if OS.mac?
      bin.install "terraphim_server-universal-apple-darwin" => "terraphim_server"
    else
      bin.install "terraphim_server-x86_64-unknown-linux-gnu" => "terraphim_server"
    end
  end

  def caveats
    <<~EOS
      Terraphim Server has been installed.

      To start the server:
        terraphim_server

      Or run as a background service:
        brew services start terraphim-server

      The server will be available at http://localhost:8000
    EOS
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
