class Asm198x < Formula
  desc "Assemblers and disassemblers for retro CPUs in a single binary"
  homepage "https://asm198x.github.io"
  version "0.0.77"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.77/asm198x-aarch64-apple-darwin.tar.xz"
      sha256 "ed37ce4415ecea95d1f3f29fb66fcb1da0b0bc13608beddfe9aca23b6ed90faf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.77/asm198x-x86_64-apple-darwin.tar.xz"
      sha256 "026d1207e8414368f871dd5c79d653eabb177eab158b511e8938886e535b4448"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.77/asm198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c4a17335f5932b3a2707ddaf8af59f4f2fe9b0372b0bbc89560d37820f816a98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.77/asm198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf9248c7d6e7f19b2e289a2b32f7b288a74cc87fa3f803357175b21acc55015c"
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
