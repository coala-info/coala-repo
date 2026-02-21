cwlVersion: v1.2
class: CommandLineTool
baseCommand: btrim
label: btrim
doc: "A tool for trimming and cleaning unitig files based on k-mer size, coverage,
  and tipping length.\n\nTool homepage: https://github.com/Malfoy/BTRIM"
inputs:
  - id: cleaning_step
    type:
      - 'null'
      - int
    doc: Cleaning Step
    default: '1'
    inputBinding:
      position: 101
      prefix: -T
  - id: cores
    type:
      - 'null'
      - int
    doc: Core used
    default: '1'
    inputBinding:
      position: 101
      prefix: -c
  - id: edge_filtering_ratio
    type:
      - 'null'
      - float
    doc: Edge filtering ratio
    inputBinding:
      position: 101
      prefix: -a
  - id: hash_size
    type:
      - 'null'
      - int
    doc: Hash size, use 2^h files (8 for 256 files)
    default: '8'
    inputBinding:
      position: 101
      prefix: -h
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size
    inputBinding:
      position: 101
      prefix: -k
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Unitig max coverage
    inputBinding:
      position: 101
      prefix: -m
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Unitig min coverage (0 for auto)
    inputBinding:
      position: 101
      prefix: -f
  - id: tipping_length
    type:
      - 'null'
      - int
    doc: Tipping length
    inputBinding:
      position: 101
      prefix: -t
  - id: unitig_file
    type:
      - 'null'
      - File
    doc: Unitig file
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/btrim:1.0.1--h9f5acd7_4
