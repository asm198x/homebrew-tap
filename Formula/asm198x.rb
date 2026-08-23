class Asm198x < Formula
  desc "A family of modern, single-binary assemblers for retro CPUs. 6502 today; more to follow."
  homepage "https://asm198x.github.io"
  version "0.0.27"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.27/asm198x-aarch64-apple-darwin.tar.xz"
      sha256 "4c241a56622aa2f0445e97be54a66a8aa460d3dff7b254013071249d107b6d4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.27/asm198x-x86_64-apple-darwin.tar.xz"
      sha256 "02c6e9e34f268f67cb63030d13b96eea959fe6e4e5c2af234f33f993d8f65204"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.27/asm198x-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "6e4ef57513fc9bae977a03c9f489fba63a86a691c381d2bbba4919bd5843925d"
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
