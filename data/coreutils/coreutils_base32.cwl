cwlVersion: v1.2
class: CommandLineTool
baseCommand: base32
label: coreutils_base32
doc: "Base32 encode or decode FILE, or standard input, to standard output.\n\nTool
  homepage: https://github.com/uutils/coreutils"
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: FILE to encode or decode. With no FILE, or when FILE is -, read standard
      input.
    inputBinding:
      position: 1
  - id: decode
    type:
      - 'null'
      - boolean
    doc: decode data
    inputBinding:
      position: 102
      prefix: --decode
  - id: ignore_garbage
    type:
      - 'null'
      - boolean
    doc: when decoding, ignore non-alphabet characters
    inputBinding:
      position: 102
      prefix: --ignore-garbage
  - id: wrap
    type:
      - 'null'
      - int
    doc: wrap encoded lines after COLS character (default 76). Use 0 to disable line
      wrapping
    default: 76
    inputBinding:
      position: 102
      prefix: --wrap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_base32.out
