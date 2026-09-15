class TerraphimGrep < Formula
  desc "Intelligent hybrid grep with knowledge-graph boosting and LLM fallback"
  homepage "https://github.com/terraphim/terraphim-ai"

  target = on_system_conditional(
    macos: "universal-apple-darwin",
    linux: on_arch_conditional(
      arm:   "aarch64-unknown-linux-musl",
      intel: "x86_64-unknown-linux-gnu",
    ),
  )
  checksum = on_system_conditional(
    macos: "e2c1b6d61593c4f4503fc498e5328939de3569c97790b1614222084f45e24d06",
    linux: on_arch_conditional(
      arm:   "16f9ee372a7e476966e4e66fac017a583af56d43e556105a3aecdaf1803b3529",
      intel: "9b556ee6b5a2cd5fbb41a025af346c07b3b35a4b61bc252c9489f3e9057299e4",
    ),
  )
  url "https://github.com/terraphim/terraphim-ai/releases/download/v1.21.3/terraphim-grep-#{target}"
  version "1.21.3"
  sha256 checksum
  license "MIT"

  def install
    binary = if OS.mac?
      "terraphim-grep-universal-apple-darwin"
    elsif Hardware::CPU.arm?
      "terraphim-grep-aarch64-unknown-linux-musl"
    else
      "terraphim-grep-x86_64-unknown-linux-gnu"
    end
    bin.install binary => "terraphim-grep"
  end

  test do
    assert_match "terraphim", shell_output("#{bin}/terraphim-grep --version 2>&1")
  end
end
