class Asm198x < Formula
  desc "A family of modern, single-binary assemblers for retro CPUs. 6502 today; more to follow."
  homepage "https://asm198x.github.io"
  version "0.0.65"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.65/asm198x-aarch64-apple-darwin.tar.xz"
      sha256 "7b4dcef1b0b6fa164eabf47293e10bbada3d8e5899a6766d2e3cfe35f141db8c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.65/asm198x-x86_64-apple-darwin.tar.xz"
      sha256 "7b3d122ad26dcda50a13c8b2f3ee48f3a2f8afeb00d18ec9e0b952f858c0893d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.65/asm198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e79305ee5208670ddbc40a97c4d3725575ce7efe35d5fcf71d961efb3fd3fc93"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.65/asm198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "02cd6c868f100a37d46fe6283927b13583594e620f966c0865f3f0a705f2d20e"
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
