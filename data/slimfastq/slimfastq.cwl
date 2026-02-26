cwlVersion: v1.2
class: CommandLineTool
baseCommand: slimfastq
label: slimfastq
doc: "Compresses and decompresses FASTQ files using a custom algorithm.\n\nTool homepage:
  https://github.com/Infinidat/slimfastq"
inputs:
  - id: input_fastq_file
    type: File
    doc: Input FASTQ file for compression
    inputBinding:
      position: 1
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for compression or decompression
    inputBinding:
      position: 2
  - id: compressed_input_file
    type: File
    doc: Required - compressed input file
    inputBinding:
      position: 103
      prefix: -f
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level 1 to 4 (default is 3)
    default: 3
    inputBinding:
      position: 103
      prefix: -l
  - id: compression_level_1
    type:
      - 'null'
      - boolean
    doc: Alias for -l 1
    inputBinding:
      position: 103
      prefix: '-1'
  - id: compression_level_2
    type:
      - 'null'
      - boolean
    doc: Alias for -l 2
    inputBinding:
      position: 103
      prefix: '-2'
  - id: compression_level_3
    type:
      - 'null'
      - boolean
    doc: Alias for -l 3
    inputBinding:
      position: 103
      prefix: '-3'
  - id: compression_level_4
    type:
      - 'null'
      - boolean
    doc: Alias for -l 4
    inputBinding:
      position: 103
      prefix: '-4'
  - id: decode
    type:
      - 'null'
      - boolean
    doc: Decode (instead of encoding)
    inputBinding:
      position: 103
      prefix: -d
  - id: input_file
    type:
      - 'null'
      - File
    doc: 'Input filename (default: stdin)'
    default: stdin
    inputBinding:
      position: 103
      prefix: -u
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Silently overwrite existing files
    inputBinding:
      position: 103
      prefix: -O
  - id: stat
    type:
      - 'null'
      - boolean
    doc: Information about a compressed file
    inputBinding:
      position: 103
      prefix: -s
  - id: suppress_stats
    type:
      - 'null'
      - boolean
    doc: Suppress extra stats info that could have been seen by -s
    inputBinding:
      position: 103
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slimfastq:2.04--h503566f_5
stdout: slimfastq.out
