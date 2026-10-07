cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crabz
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
    doc: 'The format to use [default: gzip] (gzip, bgzf, mgzip, zlib, deflate, snap)'
    inputBinding:
      position: 102
      prefix: --format
  - id: level
    type:
      - 'null'
      - int
    doc: 'Compression level [default: 6]'
    inputBinding:
      position: 102
      prefix: --compression-level
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of compression threads to use, or the number of decompression 
      threads for formats that allow multi-threaded decompression
    inputBinding:
      position: 102
      prefix: --compression-threads
  - id: pin_at
    type:
      - 'null'
      - int
    doc: Specify the physical core to pin threads at
    inputBinding:
      position: 102
      prefix: --pin-at
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: output_path
    type: string
    doc: Output path to write to
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Compressed or decompressed output file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crabz:0.9.0
