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
    macos: "bea68873624f55959fbecc9163046ca74e820f3da954e25dfd8992049eb992ff",
    linux: on_arch_conditional(
      arm:   "1b02796312162b59cd0165aa302aa683e8f57b00c72f283ab0bd15d569d3b395",
      intel: "aec89a77f43db1cf911e761e439a7f9fd3af4ede41066c315910bd8b0272a178",
    ),
  )
  url "https://downloads.terraphim.ai/terraphim-grep/terraphim-grep-1.21.18-#{target}.tar.gz"
  mirror "https://github.com/terraphim/terraphim-clients/releases/download/v1.21.18/terraphim-grep-1.21.18-#{target}.tar.gz"
  sha256 checksum
  license "MIT"

  def install
    bin.install "terraphim-grep"
    # Marks this keg as Homebrew-managed so `terraphim-grep update` defers to
    # `brew upgrade` instead of overwriting the Cellar binary.
    (share/"terraphim/package-manager.d").mkpath
    (share/"terraphim/package-manager.d"/"terraphim-grep").write "homebrew\n"
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim-grep --version 2>&1")
    assert_equal "homebrew\n", (share/"terraphim/package-manager.d"/"terraphim-grep").read
    assert_match "Intelligent hybrid grep", shell_output("#{bin}/terraphim-grep --help 2>&1")
    if OS.mac?
      system "/usr/bin/codesign", "--verify", "--all-architectures", "--deep", "--strict",
             bin/"terraphim-grep"
    end
  end
end
