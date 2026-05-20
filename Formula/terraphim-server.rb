class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.19.3"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.19.3/terraphim_server-universal-apple-darwin"
    sha256 "91147efdf69b55b75689982805ad4eaf25e72102bd312fc4a6633236c5381162"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.19.3/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "725cc9fd5a088c7d471fc12a3ca69d6a666ea357db062e3accf52c9242ca7966"
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
