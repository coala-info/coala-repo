cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbgzip
label: pbgzip
doc: "Parallel block gzip compression and decompression tool\n\nTool homepage: https://github.com/nh13/pbgzip"
inputs:
  - id: input_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s) to process
    inputBinding:
      position: 1
  - id: block_size
    type:
      - 'null'
      - int
    doc: the block size when reading uncompressed data (must be less than or equal
      to 65536; -1 is auto)
    default: -1
    inputBinding:
      position: 102
      prefix: -S
  - id: compress_type
    type:
      - 'null'
      - int
    doc: the compress type (0 - gz, 1 - bz2)
    default: 0
    inputBinding:
      position: 102
      prefix: -t
  - id: compression_level
    type:
      - 'null'
      - int
    doc: the compression level (-1 to -9)
    default: -1
    inputBinding:
      position: 102
      prefix: '-1'
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: decompress
    inputBinding:
      position: 102
      prefix: -d
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite files without asking
    inputBinding:
      position: 102
      prefix: -f
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: write on standard output, keep original files unchanged
    inputBinding:
      position: 102
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 40
    inputBinding:
      position: 102
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbgzip:2016.08.04--hb1d24b7_6
stdout: pbgzip.out
