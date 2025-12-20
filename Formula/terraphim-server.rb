class TerraphimServer < Formula
  desc "Privacy-first AI assistant HTTP server with semantic search"
  homepage "https://github.com/terraphim/terraphim-ai"
  url "https://github.com/terraphim/terraphim-ai/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "48a6d07139bab943993c4535cb970aa64169ddfb91072d6f655e295f0d229233"
  license "Apache-2.0"
  head "https://github.com/terraphim/terraphim-ai.git", branch: "main"

  depends_on "rust" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl@3"

  def install
    system "cargo", "build", "--release", "--package", "terraphim_server"
    bin.install "target/release/terraphim_server"

    # Install default configuration files
    (etc/"terraphim").mkpath
    cp_r Dir["terraphim_server/default/*.json"], etc/"terraphim"
  end

  def caveats
    <<~EOS
      Terraphim Server has been installed.

      Configuration files are located in:
        #{etc}/terraphim/

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
    working_dir HOMEBREW_PREFIX
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim_server --version 2>&1", 0)
  end
end
