class TerraphimGrep < Formula
  desc "Intelligent hybrid grep with knowledge-graph boosting and LLM fallback"
  homepage "https://github.com/terraphim/terraphim-clients"

  target = on_system_conditional(
    macos: "universal-apple-darwin",
    linux: on_arch_conditional(
      arm:   "aarch64-unknown-linux-musl",
      intel: "x86_64-unknown-linux-gnu",
    ),
  )
  checksum = on_system_conditional(
    macos: "2149c3c50cd27e303c73660011130f66ea8b55e65da6af2b794a5948b93dd139",
    linux: on_arch_conditional(
      arm:   "b09f9a2bda369f5fdd2904ac52a86a62be92a65880c00059c8e22c12a7cccdb4",
      intel: "254742d956bc4bc70f6c0c3f12632969c7300afe42774c7a8e4c93730382547a",
    ),
  )
  url "https://downloads.terraphim.ai/terraphim-grep/terraphim-grep-1.21.17-#{target}.tar.gz"
  mirror "https://github.com/terraphim/terraphim-clients/releases/download/v1.21.17/terraphim-grep-1.21.17-#{target}.tar.gz"
  sha256 checksum
  license "MIT"

  def install
    bin.install "terraphim-grep"
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim-grep --version 2>&1")
    assert_match "Intelligent hybrid grep", shell_output("#{bin}/terraphim-grep --help 2>&1")
    if OS.mac?
      system "/usr/bin/codesign", "--verify", "--all-architectures", "--deep", "--strict",
             bin/"terraphim-grep"
    end
  end
end
