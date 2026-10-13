class Asm198x < Formula
  desc "A family of modern, single-binary assemblers for retro CPUs. 6502 today; more to follow."
  homepage "https://asm198x.github.io"
  version "0.0.63"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.63/asm198x-aarch64-apple-darwin.tar.xz"
      sha256 "a31daaa0ba4695e40b08c84dec3ada36ee7f1f76ffc4113a1015a23ee4541e99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.63/asm198x-x86_64-apple-darwin.tar.xz"
      sha256 "214294c9f458a11f3c27816639a777faba40a53e3b22e83e04e5d481b6c94762"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.63/asm198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b7a50c3e01a9cdfcadde9dab9dfb61c4436def479a620f1831749af1e84fcdda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.63/asm198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c345e3be20f0c9cf983d80c3b16406fdb9877f08216d17db5a3dff5d6e8b45db"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "asm198x"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "asm198x"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "asm198x"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "asm198x"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
