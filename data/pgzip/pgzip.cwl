cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgzip
label: pgzip
doc: "A parallel implementation of gzip for compression and decompression that utilizes
  multiple cores.\n\nTool homepage: https://github.com/klauspost/pgzip"
inputs:
  - id: input_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to compress or decompress. If no file is specified, read from standard
      input.
    inputBinding:
      position: 1
  - id: best
    type:
      - 'null'
      - boolean
    doc: Compress better (slower).
    inputBinding:
      position: 102
      prefix: --best
  - id: block_size
    type:
      - 'null'
      - int
    doc: Set the block size in KiB.
    inputBinding:
      position: 102
      prefix: -b
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Decompress the input file.
    inputBinding:
      position: 102
      prefix: --decompress
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Compress faster.
    inputBinding:
      position: 102
      prefix: --fast
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force compression or decompression even if the file has multiple links or
      the corresponding file already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: list
    type:
      - 'null'
      - boolean
    doc: For each compressed file, list the uncompressed size, compressed size, ratio,
      and uncompressed name.
    inputBinding:
      position: 102
      prefix: --list
  - id: processors
    type:
      - 'null'
      - int
    doc: Number of processors to use. Defaults to the number of logical CPUs.
    inputBinding:
      position: 102
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode; display the name and percentage reduction for each file processed.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type:
      - 'null'
      - File
    doc: Write output on standard output; keep original files unchanged.
    outputBinding:
      glob: $(inputs.stdout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgzip:0.3.5
