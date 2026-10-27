class Asm198x < Formula
  desc "Assemblers and disassemblers for retro CPUs in a single binary"
  homepage "https://asm198x.github.io"
  version "0.0.73"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.73/asm198x-aarch64-apple-darwin.tar.xz"
      sha256 "a0aecede4aa7d676eb694add9bd02830caa4ce65a487bcc3a284c655938b276d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.73/asm198x-x86_64-apple-darwin.tar.xz"
      sha256 "be15466b2639431abd7d68c9db3d21494ab286c449e4d7490de3d8b93ad4f769"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.73/asm198x-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9c5a6053cddc85a622b11bf86b3eaffff25c0b6ffd50bb861e47235dfdcc6289"
    end
    if Hardware::CPU.intel?
      url "https://github.com/asm198x/asm198x/releases/download/asm198x-v0.0.73/asm198x-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "92805a12f99360fb3cbd1db13afb42d5ed5565003361cb773da2304deb1100bf"
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
