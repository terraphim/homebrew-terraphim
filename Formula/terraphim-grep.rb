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
    macos: "99ab7cd1a7767b73c766b095d42708d704b1e680f830df4e8f9d9a3e4d30795a",
    linux: on_arch_conditional(
      arm:   "703f7a9d16f4b8fefae7c0d1eecbca76b68bd65ae4e3d10b937b1a5bf7ff8a5e",
      intel: "9b335e29caf0e6bb81ef3a3eb5eceef33abcc955fb026aafc0fe09f527796f47",
    ),
  )
  url "https://downloads.terraphim.ai/terraphim-grep/terraphim-grep-1.21.14-#{target}.tar.gz"
  mirror "https://github.com/terraphim/terraphim-clients/releases/download/v1.21.14/terraphim-grep-1.21.14-#{target}.tar.gz"
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
