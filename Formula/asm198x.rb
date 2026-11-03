class Asm198x < Formula
  desc "Assemblers and disassemblers for retro CPUs in a single binary"
  homepage "https://asm198x.github.io"
  version "0.0.74"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.74/asm198x-aarch64-apple-darwin.tar.xz"
      sha256 "c04349317f769dc7cfc63b9cad79bdfb8d4f8cc4128853d25f5c8f256f8d06ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.74/asm198x-x86_64-apple-darwin.tar.xz"
      sha256 "9778174df531d5c09833cc8d4589d591b278293c6edd813a33301199a8e7e41d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.74/asm198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b2a4fb306b679a78583e1394da3dd4a8e8c44baae49d8b85ef7c72c04c23fc3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.74/asm198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e9423f8716d17e5f69f50a922427c39fb31e1512035ff749821b80b17c76320e"
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
