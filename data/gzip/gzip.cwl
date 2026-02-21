cwlVersion: v1.2
class: CommandLineTool
baseCommand: gzip
label: gzip
doc: "Compress or expand files using Lempel-Ziv coding (LZ77)\n\nTool homepage: https://github.com/bazingagin/npc_gzip"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to compress or decompress
    inputBinding:
      position: 1
  - id: best
    type:
      - 'null'
      - boolean
    doc: compress better
    inputBinding:
      position: 102
      prefix: --best
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: decompress
    inputBinding:
      position: 102
      prefix: --decompress
  - id: fast
    type:
      - 'null'
      - boolean
    doc: compress faster
    inputBinding:
      position: 102
      prefix: --fast
  - id: force
    type:
      - 'null'
      - boolean
    doc: force overwrite of output file and compress links
    inputBinding:
      position: 102
      prefix: --force
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep (don't delete) input files
    inputBinding:
      position: 102
      prefix: --keep
  - id: list
    type:
      - 'null'
      - boolean
    doc: list compressed file contents
    inputBinding:
      position: 102
      prefix: --list
  - id: name
    type:
      - 'null'
      - boolean
    doc: save or restore the original name and time stamp
    inputBinding:
      position: 102
      prefix: --name
  - id: no_name
    type:
      - 'null'
      - boolean
    doc: do not save or restore the original name and time stamp
    inputBinding:
      position: 102
      prefix: --no-name
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress all warnings
    inputBinding:
      position: 102
      prefix: --quiet
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: operate recursively on directories
    inputBinding:
      position: 102
      prefix: --recursive
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: write on standard output, keep original files unchanged
    inputBinding:
      position: 102
      prefix: --stdout
  - id: suffix
    type:
      - 'null'
      - string
    doc: use suffix SUF on compressed files
    inputBinding:
      position: 102
      prefix: --suffix
  - id: test
    type:
      - 'null'
      - boolean
    doc: test compressed file integrity
    inputBinding:
      position: 102
      prefix: --test
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gzip:1.11
stdout: gzip.out
