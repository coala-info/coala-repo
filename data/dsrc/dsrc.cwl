cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsrc
label: dsrc
doc: "DNA Sequence Reads Compressor\n\nTool homepage: https://github.com/refresh-bio/DSRC"
inputs:
  - id: mode
    type: string
    doc: Compression ('c') or decompression ('d') mode
    inputBinding:
      position: 1
  - id: input_filename
    type: File
    doc: Input filename
    inputBinding:
      position: 2
  - id: automated_compression_mode
    type:
      - 'null'
      - int
    doc: 'Compression mode: 0 (fast), 1 (better ratio), 2 (best ratio)'
    inputBinding:
      position: 103
      prefix: -m
  - id: crc32_checksum
    type:
      - 'null'
      - boolean
    doc: Calculate and check CRC32 checksum calculation per block
    inputBinding:
      position: 103
      prefix: -c
  - id: dna_compression_mode
    type:
      - 'null'
      - int
    doc: 'DNA compression mode: 0-3'
    inputBinding:
      position: 103
      prefix: -d
  - id: fastq_buffer_size
    type:
      - 'null'
      - int
    doc: FASTQ input buffer size in MB
    inputBinding:
      position: 103
      prefix: -b
  - id: fields_to_keep
    type:
      - 'null'
      - string
    doc: Keep only those fields no. in tag field string
    inputBinding:
      position: 103
      prefix: -f
  - id: lossy_quality_mode
    type:
      - 'null'
      - boolean
    doc: Use Quality lossy mode (Illumina binning scheme)
    inputBinding:
      position: 103
      prefix: -l
  - id: quality_compression_mode
    type:
      - 'null'
      - int
    doc: 'Quality compression mode: 0-2'
    inputBinding:
      position: 103
      prefix: -q
  - id: quality_offset
    type:
      - 'null'
      - int
    doc: Quality offset
    inputBinding:
      position: 103
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: Processing threads number
    inputBinding:
      position: 103
      prefix: -t
  - id: use_stdin_stdout
    type:
      - 'null'
      - boolean
    doc: Use stdin/stdout for reading/writing raw FASTQ data
    inputBinding:
      position: 103
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_filename
    type: File
    doc: Output filename
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsrc:2015.06.04--h077b44d_10
