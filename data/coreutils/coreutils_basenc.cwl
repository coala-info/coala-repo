cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenc
label: coreutils_basenc
doc: "basenc encode or decode FILE, or standard input, to standard output.\n\nTool
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
  - id: base16
    type:
      - 'null'
      - boolean
    doc: hex encoding (RFC4648 section 8)
    inputBinding:
      position: 102
      prefix: --base16
  - id: base2lsbf
    type:
      - 'null'
      - boolean
    doc: bit string with least significant bit (lsb) first
    inputBinding:
      position: 102
      prefix: --base2lsbf
  - id: base2msbf
    type:
      - 'null'
      - boolean
    doc: bit string with most significant bit (msb) first
    inputBinding:
      position: 102
      prefix: --base2msbf
  - id: base32
    type:
      - 'null'
      - boolean
    doc: same as 'base32' program (RFC4648 section 6)
    inputBinding:
      position: 102
      prefix: --base32
  - id: base32hex
    type:
      - 'null'
      - boolean
    doc: extended hex alphabet base32 (RFC4648 section 7)
    inputBinding:
      position: 102
      prefix: --base32hex
  - id: base64
    type:
      - 'null'
      - boolean
    doc: same as 'base64' program (RFC4648 section 4)
    inputBinding:
      position: 102
      prefix: --base64
  - id: base64url
    type:
      - 'null'
      - boolean
    doc: file- and url-safe base64 (RFC4648 section 5)
    inputBinding:
      position: 102
      prefix: --base64url
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
    inputBinding:
      position: 102
      prefix: --wrap
  - id: z85
    type:
      - 'null'
      - boolean
    doc: ascii85-like encoding (ZeroMQ spec:32/Z85); when encoding, input length must
      be a multiple of 4; when decoding, input length must be a multiple of 5
    inputBinding:
      position: 102
      prefix: --z85
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_basenc.out
