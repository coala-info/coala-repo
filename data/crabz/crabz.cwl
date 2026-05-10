cwlVersion: v1.2
class: CommandLineTool
baseCommand: crabz
label: crabz
doc: "A cross-platform multi-threaded compressor and decompressor.\n\nTool homepage:
  https://github.com/sstadick/crabz"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file to compress or decompress. If not provided, reads from 
      stdin.
    inputBinding:
      position: 1
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Decompress the input
    inputBinding:
      position: 102
      prefix: --decompress
  - id: format
    type:
      - 'null'
      - string
    doc: Compression format (e.g., gzip, zlib, raw, xz, lzma, bzip2, zstd)
    inputBinding:
      position: 102
      prefix: --format
  - id: level
    type:
      - 'null'
      - int
    doc: Compression level
    inputBinding:
      position: 102
      prefix: --level
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use [default: number of logical CPUs]'
    inputBinding:
      position: 102
      prefix: --threads
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name. If not provided, writes to stdout.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crabz:0.9.0
