cwlVersion: v1.2
class: CommandLineTool
baseCommand: bgzip
label: htslib_bgzip
doc: "Block compression/decompression utility using BGZF\n\nTool homepage: https://github.com/samtools/htslib"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file to compress or decompress
    inputBinding:
      position: 1
  - id: compress_level
    type:
      - 'null'
      - int
    doc: Compression level to use [0-9]
    inputBinding:
      position: 102
      prefix: --compress-level
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Decompress
    inputBinding:
      position: 102
      prefix: --decompress
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite files without asking
    inputBinding:
      position: 102
      prefix: --force
  - id: index
    type:
      - 'null'
      - boolean
    doc: Compress and create a BGZF index
    inputBinding:
      position: 102
      prefix: --index
  - id: index_name
    type:
      - 'null'
      - File
    doc: Name of the index file
    inputBinding:
      position: 102
      prefix: --index-name
  - id: offset
    type:
      - 'null'
      - int
    doc: Decompress at virtual offset
    inputBinding:
      position: 102
      prefix: --offset
  - id: rebgzip
    type:
      - 'null'
      - boolean
    doc: Use an existing index to create a new one
    inputBinding:
      position: 102
      prefix: --rebgzip
  - id: reindex
    type:
      - 'null'
      - boolean
    doc: Reindex or add index to an existing file
    inputBinding:
      position: 102
      prefix: --reindex
  - id: size
    type:
      - 'null'
      - int
    doc: Decompress a specific number of bytes
    inputBinding:
      position: 102
      prefix: --size
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Write on standard output, keep original files unchanged
    inputBinding:
      position: 102
      prefix: --stdout
  - id: test
    type:
      - 'null'
      - boolean
    doc: Test integrity of compressed file
    inputBinding:
      position: 102
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htslib:1.23--h566b1c6_0
stdout: htslib_bgzip.out
