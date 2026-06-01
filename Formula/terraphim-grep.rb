class TerraphimGrep < Formula
  desc "Intelligent hybrid grep with knowledge-graph boosting and LLM fallback"
  homepage "https://github.com/terraphim/terraphim-ai"
  version "1.20.3"
  license "MIT"

  on_macos do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.3/terraphim-grep-universal-apple-darwin"
    sha256 "4712416a4b943caaad18a98698a1aaf985fb94ccf23bbaa3133ea11a7dd6a320"
  end

  on_linux do
    url "https://github.com/terraphim/terraphim-ai/releases/download/v1.20.3/terraphim-grep-x86_64-unknown-linux-gnu"
    sha256 "c80df266979e6c4a102586e531dbfe24bafda2d625df234c2b7c98cf335dbfc5"
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
