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
    macos: "6d8c38c5d44e5b4c2b94649f325a13028d365b020cd2df7fade04d998f5450a5",
    linux: on_arch_conditional(
      arm:   "3c050c09668775dc709c098ed6bb4ac85493fb69f658848ff1ce4a62824480a9",
      intel: "f7a9daca8f9bec4d54046fcff6f393587d155be1ba8c873e93b580d25b26e796",
    ),
  )
  url "https://downloads.terraphim.ai/terraphim-grep/terraphim-grep-1.21.22-#{target}.tar.gz"
  mirror "https://github.com/terraphim/terraphim-clients/releases/download/v1.21.22/terraphim-grep-1.21.22-#{target}.tar.gz"
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
