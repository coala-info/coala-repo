cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - random
label: bamtools_random
doc: "grab a random subset of alignments.\n\nTool homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: count
    type:
      - 'null'
      - int
    doc: number of alignments to grab. Note - no duplicate checking is performed
    default: 10000
    inputBinding:
      position: 101
      prefix: -n
  - id: force_compression
    type:
      - 'null'
      - boolean
    doc: if results are sent to stdout (like when piping to another tool), default
      behavior is to leave output uncompressed. Use this flag to override and force
      compression
    inputBinding:
      position: 101
      prefix: -forceCompression
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: the input BAM file [stdin]
    inputBinding:
      position: 101
      prefix: -in
  - id: input_list
    type:
      - 'null'
      - File
    doc: the input BAM file list, one line per file
    inputBinding:
      position: 101
      prefix: -list
  - id: region
    type:
      - 'null'
      - string
    doc: only pull random alignments from within this genomic region. Index file is
      recommended for better performance, and is used automatically if it exists.
    inputBinding:
      position: 101
      prefix: -region
  - id: seed
    type:
      - 'null'
      - int
    doc: random number generator seed (for repeatable results). Current time is used
      if no seed value is provided.
    inputBinding:
      position: 101
      prefix: -seed
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: the output BAM file [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
