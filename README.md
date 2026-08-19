# asm198x Homebrew tap

Homebrew formulae for the [asm198x](https://github.com/asm198x/asm198x)
command-line assembler and disassembler.

```sh
brew install asm198x/homebrew-tap/asm198x
```

## About this repository

The formula here is **generated**, not hand-written. Each asm198x release runs
`cargo-dist`, which builds the platform archives, writes the formula from the
release's own manifest, and commits it to this repository.

So changes belong upstream: edit the packaging configuration in
[`asm198x/asm198x`](https://github.com/asm198x/asm198x) rather than the formula,
or a release will overwrite them.
