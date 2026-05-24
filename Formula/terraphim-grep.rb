class TerraphimGrep < Formula
  desc "Intelligent hybrid grep with knowledge-graph boosting and LLM fallback"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.20.0"
  license "MIT"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.0/terraphim-grep-universal-apple-darwin"
    sha256 "cd6e3b52f313b61afe18a03926e3137949bd063fff62b178bb5bc47345c6cb28"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.0/terraphim-grep-x86_64-unknown-linux-gnu"
    sha256 "ecd29166e1590d80ca2fc7a037dc3e48f2dd448027ee1399149f726906b9dacb"
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
