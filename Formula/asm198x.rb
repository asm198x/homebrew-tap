class Asm198x < Formula
  desc "Assemblers and disassemblers for retro CPUs in a single binary"
  homepage "https://asm198x.github.io"
  version "0.0.71"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.71/asm198x-aarch64-apple-darwin.tar.xz"
      sha256 "97435c1c1aaa349be4d6e1e354030306f7e909e00c14a6f21b2f6d634402978d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.71/asm198x-x86_64-apple-darwin.tar.xz"
      sha256 "7dacbbab72cd480ba303b591fda2423b2896f0e859d6984b6008f3bddd821c3d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.71/asm198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "298cff9097eff6cff5684bf09c043990061e54fff2a4c715dc5227b21aab5f25"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.71/asm198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9fb8687a8ceec1fbbdbb305418239d0cb8e9d476831f00b34a8c8fb5d91a877c"
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
