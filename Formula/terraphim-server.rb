class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.19.3"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.19.3/terraphim_server-universal-apple-darwin"
    sha256 "66fe6f7bd633a18ca40196ba6b03a046de4142ecfb96882086f7860513f3e008"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.19.3/terraphim_server-x86_64-unknown-linux-gnu"
    sha256 "77f77b19845ed112a7cbaf4a088eaebe9b791a7e3bc61446c1bc240ddd862f75"
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
