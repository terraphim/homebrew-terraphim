class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.20.5"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.5/terraphim_server-universal-apple-darwin"
    sha256 "8a27f31316b1ad82efc39bc64ff5a8345d87177ee98f90c44abb8ec8283d0aef"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.5/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "af555ac096f3d6d75fa1be3dfae4d5310712598b95ff7acaa0e983e2efbf9f37"
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
