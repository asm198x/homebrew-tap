class Asm198x < Formula
  desc "A family of modern, single-binary assemblers for retro CPUs. 6502 today; more to follow."
  homepage "https://asm198x.github.io"
  version "0.0.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.12/asm198x-aarch64-apple-darwin.tar.xz"
      sha256 "21ecd7dc678879df3b18a5629ac92061904e7e3d6568c45b9730cc0e1086ca6f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.12/asm198x-x86_64-apple-darwin.tar.xz"
      sha256 "541ec1beabe0e4c28c28bfc42c9dc8aae2d96dd2ef3a34beac6c72069d376e83"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.12/asm198x-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "bb3217e5873762ee750b211112142a8ee035f91caea9161d294b3f09616d1eae"
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
