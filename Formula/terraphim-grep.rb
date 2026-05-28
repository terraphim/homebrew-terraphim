class TerraphimGrep < Formula
  desc "Intelligent hybrid grep with knowledge-graph boosting and LLM fallback"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.20.2"
  license "MIT"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.2/terraphim-grep-universal-apple-darwin"
    sha256 "87e2c219602a7f766edb46a71bbd940e266610dd4aa11a23520013e1c6c69ae5"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.2/terraphim-grep-x86_64-unknown-linux-gnu"
    sha256 "13c967f7df41b8a93f35e0efc1903acf2da8237b6837d2f5d68907b0b98d0933"
  end

  def install
    if OS.mac?
      bin.install "terraphim-grep-universal-apple-darwin" => "terraphim-grep"
    else
      bin.install "terraphim-grep-x86_64-unknown-linux-gnu" => "terraphim-grep"
    end
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim-grep --version 2>&1", 0)
  end
end
